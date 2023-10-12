import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/entites/power_up.dart';
import 'package:newton_breakout_revival/core/enums/power_up_type.dart';

class GlobalProvider extends ChangeNotifier {
  int score = 0;
  int live = 0;
  final globalAudio = AudioPlayer();

  ///
  double paddlePowerUpWidth = 1;
  bool paddlePowerUpActive = false;
  Duration paddlePowerUpDuration = const Duration(seconds: 0);

  ///
  double bigBallPowerUpWidth = 1;
  bool bigBallPowerUpActive = false;
  Duration bigBallPowerUpDuration = const Duration(seconds: 0);

  ///
  double shieldPowerUpWidth = 1;
  bool shieldPowerUpActive = false;
  Duration shieldPowerUpDuration = const Duration(seconds: 0);

  update() {
    notifyListeners();
  }

  playGlobalMusic() {
    globalAudio.play(
      AssetSource('sounds/global_audio.mp3'),
      
    );
    globalAudio.setReleaseMode(ReleaseMode.loop);
  }

  stopGlobalMusic(){
    globalAudio.stop();
  }

  activatePowerUp(PowerUp powerUp) async {
    switch (powerUp.type) {
      case PowerUpType.ENLARGE_PADDLE:
        if (paddlePowerUpActive == false) {
          paddlePowerUpActive = true;
          paddlePowerUpWidth = 130;
          await Future.delayed(const Duration(milliseconds: 10));
          paddlePowerUpDuration = const Duration(seconds: 15);
          notifyListeners();
          paddlePowerUpWidth = 1;
        }
        break;
      case PowerUpType.BIG_BALL:
        if (bigBallPowerUpActive == false) {
          bigBallPowerUpActive = true;
          bigBallPowerUpWidth = 130;
          await Future.delayed(const Duration(milliseconds: 10));
          bigBallPowerUpDuration = const Duration(seconds: 15);
          notifyListeners();
          bigBallPowerUpWidth = 1;
        }
        break;
      case PowerUpType.SHIELD:
        if (shieldPowerUpActive == false) {
          shieldPowerUpActive = true;
          shieldPowerUpWidth = 130;
          await Future.delayed(const Duration(milliseconds: 10));
          shieldPowerUpDuration = const Duration(seconds: 10);
          notifyListeners();
          shieldPowerUpWidth = 1;
        }
        break;
      default:
    }
  }
}
