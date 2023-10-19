import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
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
    final lastPosition = position;
    velocity = Vector2.zero();
    position += Vector2(_computeBallStartPositionX(lastPosition), -40);
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
}
