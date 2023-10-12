import 'package:flame/components.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/core/entites/power_up.dart';
import 'package:newton_breakout_revival/core/enums/power_up_type.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

import 'dart:math';

class BrickCreator {
  final GameEngine gameEngine;

  BrickCreator(this.gameEngine);

  final List<BrickComponent> bricks = [];
  void createBricks() {
    const brickWidth = 40;
    const brickHeight = 10;
    const bricksPerRow = 8; // Number of bricks in each row
    const numRows = 3; // Number of rows of bricks

    final screenWidth = gameEngine.viewport.width - 30;

    const rowSpacing = 10; // Spacing between rows
    final colSpacing =
        (screenWidth - bricksPerRow * brickWidth) / (bricksPerRow + 1);

    final random = Random();

    final powerUpTypes = PowerUpType.values.toList();

    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < bricksPerRow; col++) {
        final x = col * (brickWidth + colSpacing) + colSpacing;
        final y = row * (brickHeight + rowSpacing) + 50; // Adjust 50 as needed

        final powerUpType = powerUpTypes[random.nextInt(powerUpTypes.length)];

        final brick = BrickComponent(
          w: brickWidth.toDouble(),
          powerUp: PowerUp(powerUpType),
          pos: Vector2(x + 30, y.toDouble()),
          h: brickHeight.toDouble(),
        );

        bricks.add(brick);
        gameEngine.add(brick);
      }
    }
  }

  void removeAllBricks() {
  for (final brick in bricks) {
    gameEngine.remove(brick);
  }
  bricks.clear();
}
}
