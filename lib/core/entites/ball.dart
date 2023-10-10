import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

import 'player.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<GameEngine>, CollisionCallbacks {
  final PlayerComponent player;
  final VoidCallback onGameOver;

  BallComponent({required this.player, required this.onGameOver});
  Vector2 velocity = Vector2.zero();

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
    final hitBox = CircleHitbox(
      radius: 18,
    );

    addAll([
      hitBox,
    ]);
  }

  void launch() {
    velocity = Vector2(10, -400);
    gameIsRunning = true;
  }

  void resetBall() {
    gameIsRunning = false;
    final lastPosition = position;
    velocity = Vector2.zero();
    position += Vector2(_computeBallStartPositionX(lastPosition), -45);
    width = 30;
    height = 30;
    anchor = Anchor.center;
    launch();
  }

  double _computeBallStartPositionX(NotifyingVector2 position) {
    if (position.x > gameRef.size.x / 2) {
      return -(position.x - (gameRef.size.x / 2));
    } else {
      return (gameRef.size.x / 2) - position.x;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is BrickComponent) {
      velocity.negate();
      other.removeFromParent();
    } else if (other is PlayerComponent) {
      velocity.y = -velocity.y;
      double relativePosition = position.x - player.position.x;
      velocity.x = relativePosition * 5;

    } else if (other is ScreenHitbox) {
      final collisionPoint = intersectionPoints.first;

      // Left Side Collision
      if (collisionPoint.x == 0) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Right Side Collision
      if (collisionPoint.x == game.size.x) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Top Side Collision
      if (collisionPoint.y == 0) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      // Bottom Side Collision
      if (collisionPoint.y == game.size.y) {
        resetBall();
        onGameOver(); 
      }
    }
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    
  }
}
