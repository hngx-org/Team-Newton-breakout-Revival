import 'package:flame/components.dart';

import '../../../../data/physics/game_engine.dart';

class PlayerComponent extends SpriteComponent with HasGameRef<GameEngine> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('default-player.png');

    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 20);
    width = 100;
    height = 10;
    anchor = Anchor.center;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
