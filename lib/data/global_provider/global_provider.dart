import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/entites/power_up.dart';
import 'package:newton_breakout_revival/core/enums/power_up_type.dart';
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/core/powerups/big_ball.dart';
import 'package:newton_breakout_revival/core/powerups/large_paddle.dart';
import 'package:newton_breakout_revival/core/powerups/shield_powerup.dart';
import 'package:newton_breakout_revival/data/services/db_service.dart';

class GlobalProvider extends ChangeNotifier {
  final db = locator<DBService>();
  final bigBall = locator<BigBall>();
  final largePaddle = locator<LargePaddle>();
  final shield = locator<ShieldPowerUp>();

  int score = 0;
  int live = 0;
  final globalAudio = AudioPlayer();

  

  bool isSongPlaying = true;

  update() {
    notifyListeners();
  }

  playGlobalMusic() {
    if (isSongPlaying == true) {
      globalAudio.play(
        AssetSource('sounds/global_audio.mp3'),
      );
      globalAudio.setReleaseMode(ReleaseMode.loop);
    }
  }

  stopGlobalMusic() {
    globalAudio.stop();
  }

  
}
