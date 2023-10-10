import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/presentation/views/start/game/brick_breaker_game.dart';

import 'player.dart';

class BallComponent extends SpriteComponent with HasGameRef<BrickBreakerGame> {
  final PlayerComponent player;
  final VoidCallback onGameOver;

  BallComponent({required this.player, required this.onGameOver});
  Vector2 velocity = Vector2.zero();
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('default-ball.png');

    position =
        Vector2(gameRef.size.x / 2, gameRef.size.y + player.position.y - 40);
    width = 30;
    height = 30;
    anchor = Anchor.center;
  }

  void launch() {
    // Set the initial velocity to move the ball upward.
    velocity = Vector2(20,
        -300); // Example: Move the ball upward at a speed of 1 pixel per frame.
  }

  @override
  void update(double dt) {
    // ... (other update logic)

    // Apply the velocity to move the ball.
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
    }

    if (position.y <= 0) {
      // Reverse the Y velocity to bounce off the top.
      velocity.y = -velocity.y;
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
    }

    if (position.y >=
        MediaQueryData.fromView(WidgetsBinding.instance.renderView.flutterView)
            .size
            .height) {
     
      onGameOver();// Set the game over state to true
    }
  }
}
