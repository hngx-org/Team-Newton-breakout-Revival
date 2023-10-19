import 'package:get_it/get_it.dart';
import 'package:newton_breakout_revival/core/powerups/big_ball.dart';
import 'package:newton_breakout_revival/core/powerups/large_paddle.dart';
import 'package:newton_breakout_revival/core/powerups/shield_powerup.dart';
import 'package:newton_breakout_revival/data/network/api_implementation.dart';
import 'package:newton_breakout_revival/data/network/domain.dart';
import 'package:newton_breakout_revival/data/services/db_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<DBService>(DBService());
  locator.registerSingleton<Domain>(Domain());
  locator.registerSingleton<ApiImplementation>(ApiImplementation());
  locator.registerSingleton<BigBall>(BigBall());
  locator.registerSingleton<ShieldPowerUp>(ShieldPowerUp());
  locator.registerSingleton<LargePaddle>(LargePaddle());

  locator<DBService>().setup();

}