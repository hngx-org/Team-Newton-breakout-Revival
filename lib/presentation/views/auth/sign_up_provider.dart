// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/core/model/user_model.dart';
import 'package:newton_breakout_revival/data/network/api_implementation.dart';
import 'package:newton_breakout_revival/presentation/views/auth/login_screen.dart';

class SignUpProvider extends ChangeNotifier {
  final _api = locator<ApiImplementation>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();
  bool passToggle = true;
  bool confirmPassToggle = true;

  Future<void> signup(BuildContext ctx) async {
    try {
      final res = await _api.signup(
          email: emailController.text,
          password: passController.text,
          name: nameController.text);

      UserModel data = UserModel.fromJson(json.decode(res.body));
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Account created successfully! Please log in",
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            ctx,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
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
