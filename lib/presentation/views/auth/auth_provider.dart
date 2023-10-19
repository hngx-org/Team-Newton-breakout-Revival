import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newton_breakout_revival/presentation/views/auth/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;
  final String baseUrl = "https://newtonbreakoutrevival.onrender.com";

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/game/signin"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        final user = User(
          name: userData['name'],
          email: userData['email'],
          success: userData['success'],
        );
        _user = user;

        notifyListeners();
      } else {
        final dynamic responseData = jsonDecode(response.body);
        notifyListeners();
        throw responseData['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/game/signup"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "name": name,
            "email": email,
            "password": password,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        final user = User(
            name: userData['name'],
            email: userData['email'],
            success: userData['success']);
        _user = user;

        notifyListeners();
      } else {
        final dynamic responseData = jsonDecode(response.body);
        notifyListeners();
        throw responseData['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

