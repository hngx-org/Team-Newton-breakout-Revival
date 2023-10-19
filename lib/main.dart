import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/presentation/views/auth/login_provider.dart';
import 'package:newton_breakout_revival/core/locator.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/presentation/views/auth/sign_up_provider.dart';
import 'package:newton_breakout_revival/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => SignUpProvider()),
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
