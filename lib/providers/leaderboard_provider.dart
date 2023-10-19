import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/data/services/db_key.dart';
import 'package:newton_breakout_revival/data/services/db_service.dart';

class LeaderboardProvider extends ChangeNotifier {
  final String baseUrl = "https://newtonbreakoutrevival.onrender.com";
  final _db = locator<DBService>();

  Future<List<Map<String, dynamic>>?> fetchLeaderboardData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/game/scoreboard'));

      if (response.statusCode == 200) {
        final List<dynamic> leaderboardData = jsonDecode(response.body);
        final List<Map<String, dynamic>> scores =
            List<Map<String, dynamic>>.from(leaderboardData);
        debugPrint(scores.toString());
        return scores;
      } else {
        throw 'Failed to fetch leaderboard data';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> saveScore(int score) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/game/scoreboard"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'name': _db.get(DBKey.name),
            'score': score,
          },
        ),
      );

      if (response.statusCode == 200) {
        // Score saved successfully
        debugPrint('score successfully added');
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
      // throw e.toString();
    }
  }
}
