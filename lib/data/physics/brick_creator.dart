import 'package:flame/components.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

class BrickCreator {
  final GameEngine gameEngine;

  BrickCreator(this.gameEngine);

  void createBricks() {
    const brickWidth = 40;
    const brickHeight = 10;
    const bricksPerRow = 8; // Number of bricks in each row
    const numRows = 3; // Number of rows of bricks

    final screenWidth = gameEngine.size.x;

    const rowSpacing = 10; // Spacing between rows
    final colSpacing =
        (screenWidth - bricksPerRow * brickWidth) / (bricksPerRow + 1);

    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < bricksPerRow; col++) {
        final x = col * (brickWidth + colSpacing) + colSpacing;
        final y = row * (brickHeight + rowSpacing) + 50; // Adjust 50 as needed

        final brick = BrickComponent(
            w: brickWidth.toDouble(),
            pos: Vector2(x, y.toDouble()),
            h: brickHeight.toDouble());

        gameEngine.add(brick);
      }
    }
  }
}
