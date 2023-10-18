import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/auth/auth_provider.dart';
import 'package:newton_breakout_revival/auth/login_screen.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/presentation/views/game/game_view.dart';
import 'package:newton_breakout_revival/presentation/views/home_view/home_view.dart';
import 'package:newton_breakout_revival/presentation/views/start/start_view.dart';
import 'package:newton_breakout_revival/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const NewtonBreakoutRevival(),
  ));
}

class NewtonBreakoutRevival extends StatelessWidget {
  const NewtonBreakoutRevival({super.key});

  // This widget is the root of your application
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
