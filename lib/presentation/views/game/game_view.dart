import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';
import 'package:provider/provider.dart';

class BrickBreakerGameScreen extends StatefulWidget {
  const BrickBreakerGameScreen({super.key});

  @override
  State<BrickBreakerGameScreen> createState() => _BrickBreakerGameScreenState();
}

class _BrickBreakerGameScreenState extends State<BrickBreakerGameScreen> {
  late GameEngine game;
  bool gameStarted = false;
  @override
  void initState() {
    super.initState();

    game = GameEngine(
      context,
      gameStarted: gameStarted,
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Set the color you want
    ));
  }

  @override
  void dispose() {
    game.dispose();
    game.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GlobalProvider>(builder: (context, provider, _) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(colors: [
                      Colors.green.shade900,
                      Colors.black,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    border: const Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                      top: BorderSide(color: Colors.white, width: 2),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(3),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: provider.paddlePowerUpDuration,
                                curve: Curves.easeOut,
                                width: provider.paddlePowerUpWidth,
                                height: 8,
                                onEnd: () {
                                  provider.paddlePowerUpDuration =
                                      const Duration(seconds: 0);
                                  provider.paddlePowerUpActive = false;
                                },
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.yellow.shade500,
                                        Colors.yellow.shade900,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              const Gap(10),
                              const Text(
                                "Large Paddle",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Minecraft',
                                    fontSize: 10),
                              )
                            ],
                          ),
                          const Gap(3),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: provider.bigBallPowerUpDuration,
                                curve: Curves.easeOut,
                                width: provider.bigBallPowerUpWidth,
                                height: 8,
                                onEnd: () {
                                  provider.bigBallPowerUpDuration =
                                      const Duration(seconds: 0);
                                  provider.bigBallPowerUpActive = false;
                                },
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.shade500,
                                        Colors.blue.shade900,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              const Gap(10),
                              const Text(
                                "Big Ball",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Minecraft',
                                    fontSize: 10),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: ListView.builder(
                              itemCount: provider.live,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                );
                              },
                            ),
                          ),
                          const Text(
                            'Score ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Minecraft',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          NeonBorderContainer(
                            width: 45,
                            height: 45,
                            child: Center(
                              child: Text(
                                "${provider.score}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Minecraft',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    GameWidget(
                      game: game,
                      backgroundBuilder: (context) {
                        return const Center(
                            // child: Opacity(
                            //   opacity: 0.3,
                            //   child: FlutterLogo(
                            //     size: 350,
                            //   ),
                            // ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class NeonBorderContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const NeonBorderContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.green.shade900,
          Colors.black,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        border: Border.all(
          color: const Color.fromARGB(255, 30, 249, 117), // Neon green color
          width: 2.0, // Border width
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF00FFA1), // Neon green color
            spreadRadius: 1.0,
            blurRadius: 4.0,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.elliptical(30, 15),
          topLeft: Radius.elliptical(15, 30),
        ),
      ),
      child: child,
    );
  }
}
