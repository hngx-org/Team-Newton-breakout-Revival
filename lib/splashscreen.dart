import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:newton_breakout_revival/presentation/views/start/start_view.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const StartView()));
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 251, 251),
      body: Stack(
        children: [
          Center(
            child: Lottie.asset('assets/images/console2.json', width: 200),
          ),
          const Align(
            alignment: Alignment(0, 0.2), // Adjust the Y value as needed
            child: Text(
              'Newton',
              style: TextStyle(
                fontSize: 36, // You can adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0, 0.3), // Adjust the Y value as needed
            child: Text(
              'Games',
              style: TextStyle(
                fontSize: 36, // You can adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
