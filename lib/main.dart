import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/auth/auth_provider.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/providers/leaderboard_provider.dart';
import 'package:newton_breakout_revival/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => LeaderboardProvider()),
    ],
    child: const NewtonBreakoutRevival(),
  ));
}

class NewtonBreakoutRevival extends StatelessWidget {
  const NewtonBreakoutRevival({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newton Breakout Revival',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade900),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
