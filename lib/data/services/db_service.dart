import 'package:shared_preferences/shared_preferences.dart';

class DBService {
  late SharedPreferences prefs;
  Future<void> setup() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> save(String key, String value) async {
    await prefs.setString(key, value);
  }

  String? get(String key) {
    return prefs.getString(key);
  }

  Future<void> delete(String key) async {
    await prefs.remove(key);
  }

  Future<void> clear() async {
    await prefs.clear();
  }
}
