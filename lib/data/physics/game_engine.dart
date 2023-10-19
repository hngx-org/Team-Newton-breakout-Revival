// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/core/entites/paddle.dart';
import 'package:newton_breakout_revival/core/entites/power_up.dart';
import 'package:newton_breakout_revival/core/entites/shield.dart';
import 'package:newton_breakout_revival/core/enums/power_up_type.dart';
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/core/powerups/shield_powerup.dart';
import 'package:newton_breakout_revival/core/util/levels.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/data/physics/brick_creator.dart';
import 'package:newton_breakout_revival/data/services/db_key.dart';
import 'package:newton_breakout_revival/data/services/db_service.dart';
import 'package:newton_breakout_revival/providers/leaderboard_provider.dart';
import 'package:provider/provider.dart';

class GameEngine extends FlameGame
    with PanDetector, DoubleTapDetector, HasCollisionDetection {
  final BuildContext context;
  final GlobalKey key = GlobalKey();
  Size viewport = const Size(0, 0);
  bool gameStarted = false;
  bool gamePaused = false;
  bool gameOver = false;
  bool levelUp = false;
  int levelStatus = 1;
  int remainingBricks = 0;
  GameEngine(this.context, {required this.gameStarted}) {
    // Add a lifecycle listener to get the viewport width when the game is resized.
    viewport =
        MediaQueryData.fromView(WidgetsBinding.instance.renderView.flutterView)
            .size;
  }
  late PaddleComponent paddle;
  late BallComponent ball;
  late BrickCreator brickC;
  late TextComponent textComponent;
  late GlobalProvider provider;
  late Shield shield;

  final _db = locator<DBService>();

  final _shieldPowerUp = locator<ShieldPowerUp>();

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    paddle = PaddleComponent();
    brickC = BrickCreator(this);

    shield = Shield();
    ball = BallComponent(
        player: paddle,
        onGameOver: () {
          provider.live--;

          if (provider.live > 0) {
            resetLive();
          } else {
            endGame();
          }
          provider.update();
        });
    provider = Provider.of<GlobalProvider>(context, listen: false);
    add(paddle);
    addAll([ScreenHitbox()]);
    add(ball);

    brickC.generateBricksFromPattern(context, null);
    setupText("Double Tap to \n     start");
    provider.live = 3;
    provider.update();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final newPlayerPosition = paddle.position + info.delta.global;
    if (newPlayerPosition.x - paddle.width / 2 >= 0) {
      if (newPlayerPosition.x + paddle.width / 2 <= size.x) {
        paddle.position.x = newPlayerPosition.x;
      }
    }
    super.onPanUpdate(info);
  }

  @override
  void onDoubleTap() {
    if (gameOver == true) {
      startOver();
    } else if (gameStarted == false) {
      remove(textComponent);
      startGame();
    }
    if (levelUp == true) {
      remove(textComponent);
      nextlevel();
    }

    super.onDoubleTap();
  }

  void applyPowerUp(PowerUp powerUp) async {
    switch (powerUp.type) {
      case PowerUpType.ENLARGE_PADDLE:
        paddle.increaseSize();

      case PowerUpType.BIG_BALL:
        ball.increaseBall();

      case PowerUpType.SHIELD:
        if (!_shieldPowerUp.isActive) {
          add(shield);
        }
        _shieldPowerUp.activate(
          () {
            remove(shield);
          },
          onChanged: () {
            provider.update();
          },
        );
      default:
    }
  }

  void setupText(String text) {
    textComponent = TextComponent(
        text: text, // Replace with your desired text
        textRenderer: TextPaint(
            style: const TextStyle(
          fontFamily: 'Minecraft',
          fontSize: 25,
        )));
    // Set the position for your text component.
    textComponent.position =
        Vector2(100, size.y / 2.2); // Adjust the coordinates as needed
    add(textComponent); // Add the text component to the game.
  }

  void startGame() {
    gameStarted = true;
    ball.launch();
  }

  void nextlevel() {
    provider.stopGlobalMusic();
    switch (levelStatus) {
      case 1:
        brickC.generateBricksFromPattern(context, pattern1);
      case 2:
        brickC.generateBricksFromPattern(context, pattern2);
      case 3:
        brickC.generateBricksFromPattern(context, pattern3);
      case 4:
        brickC.generateBricksFromPattern(context, pattern4);
      case 5:
        brickC.generateBricksFromPattern(context, pattern4);
      case 6:
        brickC.generateBricksFromPattern(context, pattern4);
      case 7:
        brickC.generateBricksFromPattern(context, pattern4);
      case 8:
        brickC.generateBricksFromPattern(context, pattern4);
      default:
        brickC.generateBricksFromPattern(context, null);
    }
    provider.live = 3;
    provider.update();
    levelUp = false;
    ball.launch();
    paddle.onLoad();
  }

  void startOver() {
    provider.stopGlobalMusic();
    removeWhere((component) => component is BrickComponent);
    brickC.generateBricksFromPattern(context, pattern1);
    provider.live = 3;
    provider.score = 0;
    provider.update();
    remove(textComponent);
    gameOver = false;
    startGame();
    paddle.onLoad();
  }

  void endGame() {
    if (provider.score > int.parse(provider.highScore ?? '0')) {
      provider.highScore = provider.score.toString();
      _db.save(DBKey.highScore, provider.score.toString());
      context
          .read<LeaderboardProvider>()
          .saveScore(int.parse(provider.highScore!));
    }

    gameOver = true;
    gameStarted = false;
    provider.playGlobalMusic();
    setupText("GAME OVER\n\n Double tap to\n start all over");
    if (provider.isSongPlaying) {
      provider.playGlobalMusic();
    }
    provider.update();
  }

  void pauseGame() {
    gamePaused = !gamePaused;
    if (gamePaused == true) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    provider.update();
  }

  void resetLive() {
    gameStarted = false;
    setupText("Double Tap screen\n    to continue");
    paddle.onLoad();
  }

  void dispose() {
    removeAll([
      paddle,
      ball,
    ]);
  }

  @override
  void onDispose() {
    removeAll([paddle, ball]);
    super.onDispose();
  }

  ///// THESE FEATURES ARE UNDER TESTING
  ///
  ///
  ///
  void drawFrame(Canvas canvas) {
    final framePaint = Paint()
      ..color = Colors.green.shade900 // Frame color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0; // Frame border width (adjust as needed)

    final frameRect = Rect.fromPoints(
      const Offset(0, 0), // Top-left corner of the frame
      Offset(size.x, size.y), // Bottom-right corner of the frame
    );

    canvas.drawRect(frameRect, framePaint);
  }

  void setLevel() {
    levelUp = true;
    ball.velocity = Vector2.zero();
    ball.position = Vector2(size.x / 2, size.y - 45);
    setupText(
        "Level $levelStatus achieved \n\nDouble Tap to\n move to Level ${levelStatus + 1}");
    levelStatus += 1;
  }
}
