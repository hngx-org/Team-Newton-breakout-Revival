import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/presentation/views/start/start_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalProvider()),
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
      home: const StartView(),
    );
  }
}
