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
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/1.png"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  height: 40,
                  width: 300, // Set the outer container to have full width
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.yellow.shade900, width: 4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 10),
                              curve: Curves.easeOut,
                              width: innerContainerWidth,
                              height: 40,
                              onEnd: () {
                                _leaveLoading();
                              },
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.shade500,
                                      Colors.blue.shade900,
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
