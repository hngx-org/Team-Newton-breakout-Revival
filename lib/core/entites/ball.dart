import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/core/powerups/big_ball.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

import 'paddle.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<GameEngine>, CollisionCallbacks {
  final PaddleComponent player;
  final VoidCallback onGameOver;

  BallComponent({required this.player, required this.onGameOver}) {
    player.onLoad();
  }
  Vector2 velocity = Vector2.zero();
  final audioPlayer = AudioPlayer();

  bool bigBallActfive = false;
  bool gameIsRunning = false;

  final hitBox = CircleHitbox();

  final _ballPowerUp = locator<BigBall>();
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('default-ball.png');

    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 40);
    width = 15;
    height = 15;
    anchor = Anchor.center;

    add(hitBox);
  }

  void launch() {
    velocity = Vector2(10, -400);
    gameIsRunning = true;
  }

  _reloadHitBox() {
    remove(hitBox);
    add(hitBox);
  }

  Future<void> increaseBall() async {
    width = 35;
    height = 35;
    _reloadHitBox();
    _ballPowerUp.activate(
      () {
        width = 15;
        height = 15;
        _reloadHitBox();
      },
      onChanged: () {
        gameRef.provider.update();
      },
    );
  }

  void resetBall() {
    gameIsRunning = false;
    velocity = Vector2.zero();
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 40);
    anchor = Anchor.center;
    gameRef.provider.update();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is BrickComponent) {
      other.removeFromParent();
    } else if (other is PaddleComponent) {
    } else if (other is ScreenHitbox) {
      final collisionPoint = intersectionPoints.first;
      // Left Side Collision
      if (collisionPoint.x == 0) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Right Side Collision
      if (collisionPoint.x.toInt() == game.size.x.toInt()) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Top Side Collision
      if (collisionPoint.y == 0) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      // Bottom Side Collision
      if (collisionPoint.y.toInt() == game.size.y.toInt()) {
        resetBall();
        onGameOver();
      }
      FlameAudio.play('wall-hit.wav');
    }
  }

  @override
  void update(double dt) {
    position += velocity * dt;

    if (player.toRect().overlaps(toRect())) {
      // Reverse the Y velocity to bounce off the paddle.
      velocity.y = -velocity.y;

      // Optionally, adjust the ball's horizontal velocity based on its position relative to the paddle's center.
      // Calculate the position difference between the ball and the center of the paddle.
      double relativePosition = position.x - player.position.x;
      // Scale the X velocity based on the relative position.
      velocity.x = relativePosition * 5;
    }
  }

  // @override
  // void update(double dt) {
  //   // ... (other update logic)

  //   // Apply the velocity to move the ball.
  //   position += velocity * dt;
  //   // Check for collisions with the screen boundaries.
  //   if (position.x <= 0 ||
  //       position.x >=
  //           MediaQueryData.fromView(
  //                   WidgetsBinding.instance.renderView.flutterView)
  //               .size
  //               .width) {
  //     // Reverse the X velocity to bounce off the sides.
  //     velocity.x = -velocity.x;
  //   }

  //   if (position.y <= 0) {
  //     // Reverse the Y velocity to bounce off the top.
  //     velocity.y = -velocity.y;
  //   }

  //   // Check for collisions with the player (paddle).
  //   if (player.toRect().overlaps(toRect())) {
  //     // Reverse the Y velocity to bounce off the paddle.
  //     velocity.y = -velocity.y;

  //     // Optionally, adjust the ball's horizontal velocity based on its position relative to the paddle's center.
  //     // Calculate the position difference between the ball and the center of the paddle.
  //     double relativePosition = position.x - player.position.x;
  //     // Scale the X velocity based on the relative position.
  //     velocity.x = relativePosition * 5;
  //   }

  //   if (position.y >=
  //       MediaQueryData.fromView(WidgetsBinding.instance.renderView.flutterView)
  //           .size
  //           .height) {
  //     resetBall();

  //     onGameOver(); // Set the game over state to true
  //   }
  // }
}
