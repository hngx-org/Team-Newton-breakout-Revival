import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/core/entites/player.dart';
import 'package:newton_breakout_revival/data/physics/brick_creator.dart';

class GameEngine extends FlameGame with PanDetector, HasCollisionDetection {
  final BuildContext context;
  final GlobalKey key = GlobalKey();
  double viewportWidth = 0.0;
  bool gameStarted = false;
  bool gameOver = false;

  GameEngine(this.context, {required this.gameStarted}) {
    // Add a lifecycle listener to get the viewport width when the game is resized.
    viewportWidth =
        MediaQueryData.fromView(WidgetsBinding.instance.renderView.flutterView)
            .size
            .width;
  }
  late PlayerComponent player;
  late BallComponent ball;
  late BrickComponent brick;
  late BrickCreator brickC;
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    player = PlayerComponent();
    brickC = BrickCreator(this);
    ball = BallComponent(
        player: player,
        onGameOver: () {
          resetGame();
        });
    add(player);
    addAll([ScreenHitbox()]);
    add(ball);
    brickC.createBricks();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final newPlayerPosition = player.position + info.delta.game;
    if (newPlayerPosition.x - player.width / 2 >= 0) {
      if (newPlayerPosition.x + player.width / 2 <= viewportWidth) {
        player.position.x = newPlayerPosition.x;
      }
    }
    super.onPanUpdate(info);
  }

  void startGame() {
    gameOver = false;
    gameStarted = true; // Set the game state to started
    ball.launch(); // Implement the "launch" method in your BallComponent.
  }

  void resetGame() {
    gameOver = true;
    player.onLoad();
  }

  void dispose() {
    removeAll([player, ball, brick]);
  }

  @override
  void onDispose() {
    removeAll([player, ball, brick]);
    super.onDispose();
  }
}
