import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

class Shield extends SpriteComponent
    with HasGameReference<GameEngine>, CollisionCallbacks {
  final Paint _paint = Paint()
    ..color = Colors.green.shade900
    ..style = PaintingStyle.stroke
    ..strokeWidth = 30.0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('red_brick.png');
    position = Vector2(game.size.x / 2, game.size.y - 10);
    width = game.size.x;
    height = 10;
    anchor = Anchor.center;
    add(RectangleHitbox(isSolid: true));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is BallComponent) {
      other.velocity.negate();

      FlameAudio.play('long-paddle.wav');
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(
        Offset(0, game.size.y), Offset(game.size.y, game.size.y), _paint);
  }
}
