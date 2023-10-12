import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

class Shield extends SpriteComponent with HasGameRef<GameEngine>, CollisionCallbacks{
  final Paint _paint = Paint()
      ..color = Colors.green.shade900 
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0; 
      bool powerUpActive = false;
  @override
  FutureOr<void> onLoad() async{


    sprite = await gameRef.loadSprite('red_brick.png');

    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 10);
    width = gameRef.size.x;
    height = 10;
    anchor = Anchor.center;
    add(RectangleHitbox());
    return super.onLoad();
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is BallComponent) {
      other.velocity.negate();
    }
    
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(Offset(0, gameRef.size.y), Offset(gameRef.size.y, gameRef.size.y), _paint);
  }
}