import 'package:audioplayers/audioplayers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../../data/physics/game_engine.dart';

class PaddleComponent extends SpriteComponent
    with HasGameRef<GameEngine>, CollisionCallbacks {
  Timer? sizeTimer;
  bool powerUpActive = false;
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('default-player.png');

    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 20);
    width = 70;
    height = 10;
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  Future<void> increaseSize() async {
    final player = AudioPlayer();

    powerUpActive = true;
    player.play(AssetSource('sounds/long-paddle.wav'));
    width = 150;
    await Future.delayed(const Duration(seconds: 15));
    width = 70;
    powerUpActive = false;
    player.play(AssetSource('sounds/long-paddle.wav'));
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
