import 'package:flame/components.dart';
import 'package:newton_breakout_revival/core/entites/brick.dart';
import 'package:newton_breakout_revival/core/entites/power_up.dart';
import 'package:newton_breakout_revival/core/enums/power_up_type.dart';
import 'package:newton_breakout_revival/core/util/levels.dart';
import 'package:newton_breakout_revival/core/util/size_config.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';

import 'dart:math';

class BrickCreator {
  final GameEngine gameEngine;

  BrickCreator(this.gameEngine);
  static const brickWidth = 40;
  static const brickHeight = 10;
  static final powerUpTypes = PowerUpType.values.toList();
  final random = Random();
  final List<BrickComponent> bricks = [];

  void removeAllBricks() {
    for (final brick in bricks) {
      gameEngine.remove(brick);
    }
    bricks.clear();
  }

  List<BrickComponent> generateBricksFromPattern(context, String? pattern) {
    String generatedPattern = pattern ?? pattern1;
    double brickWidth = 30.0; // Width of each brick
    double brickHeight = 10.0; // Height of each brick
    double rowSpacing =
        SizeConfig.fromHeight(context, 3); // Vertical spacing between rows
    double colSpacing = -10; // Horizontal spacing between columns

    List<String> lines = generatedPattern.trim().split('\n');
    int numRows = lines.length;
    int numColumns = lines[0].length;

    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < numColumns; col++) {
        String brickSymbol = lines[row][col];
        final powerUpType = powerUpTypes[random.nextInt(powerUpTypes.length)];
        if (brickSymbol == '#') {
          // Calculate the position of the brick
          double x = col * (brickWidth + colSpacing);
          double y = row * (brickHeight + rowSpacing);

          // Create a brick at the calculated position
          BrickComponent brick = BrickComponent(
            w: brickWidth,
            h: brickHeight,
            powerUp: PowerUp(powerUpType),
            pos: Vector2(x + 30, y),
          );

          // Add the brick to your list of bricks or game engine
          bricks.add(brick);
          gameEngine.add(brick);
          gameEngine.remainingBricks++;
        }
        if (brickSymbol == '*') {
          // Calculate the position of the brick
          double x = col * (brickWidth + colSpacing);
          double y = row * (brickHeight + rowSpacing);

          // Create a brick at the calculated position
          BrickComponent brick = BrickComponent(
            w: brickWidth,
            h: brickHeight,
            powerUp: PowerUp(PowerUpType.BIG_BALL),
            pos: Vector2(x + 50, y),
          );

          // Add the brick to your list of bricks or game engine
          bricks.add(brick);
          gameEngine.add(brick);
        }
      }
    }

    return bricks;
  }
}
