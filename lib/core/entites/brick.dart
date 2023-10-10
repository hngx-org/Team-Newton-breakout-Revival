import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

class BrickComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<GameEngine> {
  BrickComponent(
      {required this.pos, required this.h, required this.w, super.key});

  final Vector2 pos;
  final double h;
  final double w;
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    width = w;
    height = h;
    sprite = await gameRef.loadSprite("green_brick.png");
    // position = Vector2(gameRef.size.x / 2, 100);
    position = pos;
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is BallComponent) {
      // print(intersectionPoints.first);
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is BallComponent) {
      //...
    }
  }
}
