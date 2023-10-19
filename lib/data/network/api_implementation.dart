import 'package:http/http.dart';
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/data/network/domain.dart';

class ApiImplementation {
  final _api = locator<Domain>();
  // final _db = locator<DBService>();

  Future<Response> login(
      {required String email, required String password}) async {
    final res = await _api.post(
      "game/signin",
      body: {
        "email": email,
        "password": password,
      },
    );
    return res;
  }

  Future<Response> signup(
      {required String email,
      required String password,
      required String name}) async {
    final res = await _api.post(
      "game/signup",
      body: {
        "email": email,
        "password": password,
        "name": name,
      },
    );
    return res;
  }
}
