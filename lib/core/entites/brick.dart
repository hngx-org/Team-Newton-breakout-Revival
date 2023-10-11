import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/core/entites/power_up.dart';
import 'package:newton_breakout_revival/core/enums/power_up_type.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

class BrickComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<GameEngine> {
  BrickComponent(
      {required this.pos,
      required this.h,
      required this.w,
      this.powerUp,
      super.key});

  final Vector2 pos;
  final double h;
  final double w;
  final PowerUp? powerUp;
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    width = w;
    height = h;
    sprite = await gameRef.loadSprite(_getSprite());
    // position = Vector2(gameRef.size.x / 2, 100);
    position = pos;
    anchor = Anchor.center;
    add(RectangleHitbox(isSolid: true));
  }

  String _getSprite() {
    switch (powerUp?.type) {
      case PowerUpType.ENLARGE_PADDLE:
        return "add100_brick.png";

      case PowerUpType.BIG_BALL:
        return "blue_brick.png";
      default:
        return "green_brick.png";
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is BallComponent) {
      if (powerUp != null) {
        gameRef.applyPowerUp(powerUp ?? PowerUp(PowerUpType.EMPTY));
      }
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
