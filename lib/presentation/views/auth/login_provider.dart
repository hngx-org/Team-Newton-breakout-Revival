// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/core/model/user_model.dart';
import 'package:newton_breakout_revival/core/util/loader.dart';
import 'package:newton_breakout_revival/data/network/api_implementation.dart';
import 'package:newton_breakout_revival/data/services/db_key.dart';
import 'package:newton_breakout_revival/data/services/db_service.dart';
import 'package:newton_breakout_revival/presentation/views/home_view/home_view.dart';

class LoginProvider extends ChangeNotifier {
  final _api = locator<ApiImplementation>();
  final _db = locator<DBService>();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  Future<void> login(BuildContext ctx) async {
    final loader = Loader(ctx);
    try {
      loader.show();
      final res = await _api.login(
        email: emailController.text,
        password: passController.text,
      );
      loader.close();
      UserModel data = UserModel.fromJson(json.decode(res.body));
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(
              "Signed in Successfully as ${data.email}",
              style: const TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.green,
          ),
        );

        _db.save(DBKey.email, data.email!);
        _db.save(DBKey.name, data.name!);
        Navigator.pushReplacement(
            ctx,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ));
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(
              data.message.toString(),
              style: const TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            e.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
