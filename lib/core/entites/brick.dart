import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
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

  ////new particles
  late ParticleSystemComponent particle;

  late SpriteAnimationComponent explosionAnimation;

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

    ////////////////////////////////////////////
    ///please you can select either the explotion or the particle

    final spritesheet = await gameRef.images.load('fragments.png');

    final frameData = SpriteAnimationData.sequenced(
      amount: 8, // Number of frames in the animation
      stepTime: 0.05, // Duration of each frame
      textureSize: Vector2(30, 30), // Size of each frame in the spritesheet
    );

    // Create a SpriteAnimation from the spritesheet and frame data
    final explosionSpriteAnimation = SpriteAnimation.fromFrameData(
      spritesheet,
      frameData,
    );

    explosionAnimation = SpriteAnimationComponent(
      animation: explosionSpriteAnimation,
      size: Vector2.all(30), // Set the size of the animation
      position: pos,
      // Set to true if you want the animation to loop
      removeOnFinish: true, // Remove the component when the animation finishes
    );

    // Add the explosion animation to the component list

    ////////////////////////////////////////////

    particle = ParticleSystemComponent(
      particle: Particle.generate(
        count: 20,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: randomVector2(),
          speed: randomVector2(),
          position: pos.clone(),
          child: CircleParticle(
            radius: 3,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );
  }

  ///according to documentation,please check and confirm
  Random rnd = Random();

  Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 500;

  String _getSprite() {
    switch (powerUp?.type) {
      case PowerUpType.ENLARGE_PADDLE:
        return "add100_brick.png";

      case PowerUpType.BIG_BALL:
        return "blue_brick.png";
      case PowerUpType.SHIELD:
        return "red_brick.png";
      default:
        return "green_brick.png";
    }
  }

  List<int> allLevels = [24, 48, 96];

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is BallComponent) {
      if (other.width > 15) {
        other.velocity.negate();
      }
      other.velocity.negate();
      FlameAudio.play('wall-hit.wav');
      gameRef.provider.score++;
      gameRef.provider.update();

      ///check this also
      gameRef.add(particle);
      gameRef.add(explosionAnimation);
      explosionAnimation.animation!.loop = false;

      // for (var level in allLevels) {
      //   if (gameRef.provider.score == level) {
      //     gameRef.setLevel();
      //   }
      // }
      if (gameRef.remainingBricks != 0) {
        gameRef.remainingBricks--;
        if (gameRef.remainingBricks == 0) {
          gameRef.setLevel();
        }
      }
    }
    if (powerUp != null) {
      gameRef.applyPowerUp(powerUp ?? PowerUp(PowerUpType.EMPTY));
    }
  }

  @override
  toString() => 'BrickComponent(powerup: $powerUp)';
}
