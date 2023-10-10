import 'package:audioplayers/audioplayers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

import 'player.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<GameEngine>, CollisionCallbacks {
  
  final PlayerComponent player;
  final VoidCallback onGameOver;

  BallComponent({required this.player, required this.onGameOver}){
       player.onLoad();
  }
  Vector2 velocity = Vector2.zero();
  final audioPlayer = AudioPlayer();

  bool gameIsRunning = true;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('default-ball.png');

    position =
        Vector2(gameRef.size.x / 2, gameRef.size.y + player.position.y - 45);
    width = 30;
    height = 30;
    anchor = Anchor.center;
  }

  void launch() {
    gameIsRunning = true;
    // Set the initial velocity to move the ball upward.
    velocity = Vector2(20,
        -300); // Example: Move the ball upward at a speed of 1 pixel per frame.
  }

  void resetBall() {
    gameIsRunning = false;
    final lastPosition = position;
    velocity = Vector2.zero();
    position += Vector2(_computeBallStartPositionX(lastPosition), -45);
    width = 30;
    height = 30;
    anchor = Anchor.center;
  }

  double _computeBallStartPositionX(NotifyingVector2 position) {
    if (position.x > gameRef.size.x / 2) {
      return -(position.x - (gameRef.size.x / 2));
    } else {
      return (gameRef.size.x / 2) - position.x;
    }
  }

  @override
  void update(double dt) async {
    // ... (other update logic)
    // print(position);

    // Apply the velocity to move the ball.
    if (gameIsRunning) {
      position += velocity * dt;
      // Check for collisions with the screen boundaries.
      if (position.x <= 0 ||
          position.x >=
              MediaQueryData.fromView(
                      WidgetsBinding.instance.renderView.flutterView)
                  .size
                  .width) {
       
        // Reverse the X velocity to bounce off the sides.
        velocity.x = -velocity.x;
         await audioPlayer.play(AssetSource('sounds/wall-hit.wav'));
      }

      if (position.y <= 0) {
        // Reverse the Y velocity to bounce off the top.
        
        velocity.y = -velocity.y;
         await audioPlayer.play(AssetSource('sounds/wall-hit.wav'));
      }

      // Check for collisions with the player (paddle).
      if (player.toRect().overlaps(toRect())) {
         
        // Reverse the Y velocity to bounce off the paddle.
        velocity.y = -velocity.y;

        // Optionally, adjust the ball's horizontal velocity based on its position relative to the paddle's center.
        // Calculate the position difference between the ball and the center of the paddle.
        double relativePosition = position.x - player.position.x;
        // Scale the X velocity based on the relative position.
        velocity.x = relativePosition * 5;
          await audioPlayer.play(AssetSource('sounds/paddle-hit.wav'));
      }

      if (position.y >=
          MediaQueryData.fromView(
                  WidgetsBinding.instance.renderView.flutterView)
              .size
              .height) {
        resetBall();
        onGameOver(); // Set the game over state to true
      }
    } else {
      // print(velocity*dt);
    }
  }
}
