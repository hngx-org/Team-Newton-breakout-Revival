import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeaderboardProvider extends ChangeNotifier {
  final String baseUrl = "https://newtonbreakoutrevival.onrender.com";

  Future<List<Map<String, dynamic>>?> fetchLeaderboardData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/game/scoreboard'));

      if (response.statusCode == 200) {
        final List<dynamic> leaderboardData = jsonDecode(response.body);
        final List<Map<String, dynamic>> scores =
            List<Map<String, dynamic>>.from(leaderboardData);
        print(scores);
        return scores;
      } else {
        throw 'Failed to fetch leaderboard data';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> saveScore(String name, int score) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/game/scoreboard"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'name': name,
            'score': score,
          },
        ),
      );

      if (response.statusCode == 200) {
        // Score saved successfully
        print('score successfully added');
        // You can add further handling here if needed
      } else if (response.statusCode == 400) {
        // Invalid user
        final dynamic responseData = jsonDecode(response.body);
        throw responseData['message'];
      } else {
        // Handle other error cases here
        throw 'An error occurred';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
