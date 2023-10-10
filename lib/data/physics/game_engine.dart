import 'dart:async';

import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/core/entites/player.dart';

class GameEngine extends FlameGame with PanDetector , HasCollisionDetection{
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
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    debugMode = true;
    player = PlayerComponent();
    brick = BrickComponent();
    ball = BallComponent(
        player: player,
        onGameOver: () {
          resetGame();
        });

    add(player);
    add(ball);
    add(brick);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final newPlayerPosition = player.position + info.delta.game;
    // Ensure the sprite stays within the left boundary.

    if (newPlayerPosition.x - player.width / 2 >= 0) {
      // Check if the right edge of the sprite is within the right boundary.
      if (newPlayerPosition.x + player.width / 2 <= viewportWidth) {
        // Update the X position.
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
}
