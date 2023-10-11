// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/presentation/views/home_view/home_view.dart';


class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  double innerContainerWidth = 0.0;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        innerContainerWidth = 292; // Set the desired final width
      });
    });
    super.initState();
  }

  _leaveLoading() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
          gradient: RadialGradient(
            colors: [
              Colors.green.shade500.withOpacity(0.8),
              Colors.green.shade900.withOpacity(1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "Newton",
                  style: TextStyle(
                      fontSize: 30, fontFamily: 'Game', color: Colors.white),
                ),
                const SizedBox(
                  height: 60,
                ),
                Stack(
                  children: [
                    Text(
                      "Breakout\nRevival",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 60,
                          fontFamily: 'Game',
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 5
                            ..color = Colors.yellow.shade900),
                    ),
                    const Text(
                      "Breakout\nRevival",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 60,
                          fontFamily: 'Game',
                          color: Colors.black),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: 300, // Set the outer container to have full width
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.yellow.shade900, width: 4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(
                                seconds: 10), 
                            curve: Curves.easeOut, 
                            width:
                                innerContainerWidth, 
                            height: 40,
                            onEnd: () {
                              _leaveLoading();
                            },
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.green.shade500,
                                    Colors.green.shade900,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      const Center(
                        child: Text(
                          "Loading...",
                          style: TextStyle(
                              fontFamily: 'Minecraft',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
