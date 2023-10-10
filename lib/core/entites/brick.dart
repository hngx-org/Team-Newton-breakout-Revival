import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

class BrickComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<GameEngine> {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    debugMode = true;
    width = 100;
    height = 100;

    position = Vector2(gameRef.size.x / 2, 100);
    anchor = Anchor.center;
    add(RectangleHitbox(
      isSolid: true,
        size: Vector2(100, 100),
        position: Vector2(gameRef.size.x / 2, 100),
        anchor: Anchor.center));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is BallComponent) {
      //...
    }
    print("O TI SEEE");
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is BallComponent) {
      //...
    }

    print("O TI SEEE");
  }
}
