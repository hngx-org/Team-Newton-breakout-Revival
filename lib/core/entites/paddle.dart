import 'package:audioplayers/audioplayers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';

import '../../../../data/physics/game_engine.dart';

class PaddleComponent extends SpriteComponent
    with HasGameRef<GameEngine>, CollisionCallbacks {
  Timer? sizeTimer;
  bool powerUpActive = false;
  final audioPlayer = AudioPlayer();
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('default-player.png');

    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 20);
    width = 70;
    height = 10;
    anchor = Anchor.center;

    add(RectangleHitbox(
      isSolid: true,
    ));
  }

  Future<void> increaseSize() async {
    powerUpActive = true;
    FlameAudio.play('long-paddle.wav');
    width = 150;
    await Future.delayed(const Duration(seconds: 15));
    FlameAudio.play('long-paddle.wav');
    width = 70;
    powerUpActive = false;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BallComponent) {
      FlameAudio.play('paddle-hit.wav');
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
