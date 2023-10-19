import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:newton_breakout_revival/core/entites/ball.dart';
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/core/powerups/large_paddle.dart';

import '../../../../data/physics/game_engine.dart';

class PaddleComponent extends SpriteComponent
    with HasGameRef<GameEngine>, CollisionCallbacks {
  Timer? sizeTimer;
  bool powerUpActive = false;
  final audioPlayer = AudioPlayer();

  final _paddlePowerUp = locator<LargePaddle>();
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
    FlameAudio.play('long-paddle.wav');
    if (position.x >= 0 && position.x <= 82) {
      final lastX = position.x;
      position.x += (82 - lastX);
    }
    if (position.x >= gameRef.size.x - 82 && position.x <= gameRef.size.x) {
      final lastX = position.x;
      position.x -= (gameRef.size.x - lastX);
    }

    width = 150;
    _paddlePowerUp.activate(
      () {
        width = 70;
        FlameAudio.play('long-paddle.wav');
      },
      onChanged: () {
        gameRef.provider.update();
      },
    );
  }

  void move(Vector2 delta) {
    if (gameRef.gamePaused != true) {
      position.add(delta);
    }
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
