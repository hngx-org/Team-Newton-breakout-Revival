import 'package:audioplayers/audioplayers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

import 'paddle.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<GameEngine>, CollisionCallbacks {
  final PaddleComponent player;
  final VoidCallback onGameOver;

  BallComponent({required this.player, required this.onGameOver}){
       player.onLoad();
  }
  Vector2 velocity = Vector2.zero();
  final audioPlayer = AudioPlayer();

  bool bigBallActive = false;
  bool gameIsRunning = true;

  final hitBox = CircleHitbox();
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('default-ball.png');

    position =
        Vector2(gameRef.size.x / 2, gameRef.size.y  -40);
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
    bigBallActive = true;
    width = 35;
    height = 35;
    _reloadHitBox();
    await Future.delayed(const Duration(seconds: 15));
    width = 15;
    height = 15;
    _reloadHitBox();
    bigBallActive = false;
  }

  void resetBall() {
    gameIsRunning = false;
    final lastPosition = position;
    velocity = Vector2.zero();
    position += Vector2(_computeBallStartPositionX(lastPosition), - 40);
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
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other)  async {
    super.onCollisionStart(intersectionPoints, other);

    if (other is BrickComponent) {
        await audioPlayer.play(AssetSource('sounds/wall-hit.wav'));
      velocity.negate();
      other.removeFromParent();
    } else if (other is PaddleComponent) {
        await audioPlayer.play(AssetSource('sounds/paddle-hit.wav'));
      velocity.y = -velocity.y;
      double relativePosition = position.x - player.position.x;
      velocity.x = relativePosition * 5;
    } else if (other is ScreenHitbox) {
      final collisionPoint = intersectionPoints.first;
      // Left Side Collision
      if (collisionPoint.x == 0) {
          await audioPlayer.play(AssetSource('sounds/wall-hit.wav'));
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Right Side Collision
      if (collisionPoint.x.toInt() == game.size.x.toInt()) {
          await audioPlayer.play(AssetSource('sounds/wall-hit.wav'));
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Top Side Collision
      if (collisionPoint.y == 0) {
          await audioPlayer.play(AssetSource('sounds/wall-hit.wav'));
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      // Bottom Side Collision
      if (collisionPoint.y.toInt() == game.size.y.toInt()) {
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
