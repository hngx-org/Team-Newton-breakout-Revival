import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/core/entites/paddle.dart';
import 'package:newton_breakout_revival/core/entites/power_up.dart';
import 'package:newton_breakout_revival/core/enums/power_up_type.dart';
import 'package:newton_breakout_revival/data/physics/brick_creator.dart';

class GameEngine extends FlameGame
    with PanDetector, DoubleTapDetector, HasCollisionDetection {
  final BuildContext context;
  final GlobalKey key = GlobalKey();
  Size viewport = const Size(0, 0);
  bool gameStarted = false;
  bool gameOver = false;

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

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    //  THIS IS IN TEST MODE!!!!!
    ///?? IT IS NOT FULLY FUNCTIONAL
    ///  PLEASE TURN IF OFF BEFORE WORKING SO AS NOT TO CAUSE ISSUES

    // drawFrame(canvas);

  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    paddle = PaddleComponent();
    brickC = BrickCreator(this);
    ball = BallComponent(
        player: paddle,
        onGameOver: () {
          resetGame();
        });
    add(paddle);
    addAll([ScreenHitbox()]);
    add(ball);
    brickC.createBricks();

    setupText("Double Tap to \n     start");
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final newPlayerPosition = paddle.position + info.delta.game;
    if (newPlayerPosition.x - paddle.width / 2 >= 0) {
      if (newPlayerPosition.x + paddle.width / 2 <= viewport.width) {
        paddle.position.x = newPlayerPosition.x;
      }
    }
    super.onPanUpdate(info);
  }

  @override
  void onDoubleTap() {
    if (gameOver == true) {
      remove(textComponent);
      startGame();
    }
    if (gameStarted == false && gameOver == false) {
      remove(textComponent);
      startGame();
    }
    super.onDoubleTap();
  }

  void applyPowerUp(PowerUp powerUp) {
    switch (powerUp.type) {
      case PowerUpType.ENLARGE_PADDLE:
        if (paddle.powerUpActive == false) {
          paddle.increaseSize();
        }
      case PowerUpType.BIG_BALL:
        if (ball.bigBallActive == false) {
          ball.increaseBall();
        }
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
    gameOver = false;
    gameStarted = true; // Set the game state to started
    ball.launch(); // Implement the "launch" method in your BallComponent.
  }

  void resetGame() {
    gameOver = true;
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
}
