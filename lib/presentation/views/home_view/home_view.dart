import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/presentation/animation/moving_ball.dart';
import 'package:newton_breakout_revival/presentation/animation/moving_paddle.dart';
import 'package:newton_breakout_revival/presentation/views/game/game_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GlobalProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);
    provider.playGlobalMusic();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 23, 136, 192),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/BreakouT.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const MovingBall(),
                const MovingPaddle(),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                width: 400,
                                height: 400,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  scale: 0.1,
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/images/settings_dialog.png",
                                  ),
                                )),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              log('play');
                                              final audioPlayer = AudioPlayer();
                                              await audioPlayer.play(
                                                  AssetSource(
                                                      'sounds/wall-hit.wav'));
                                            },
                                            child: Image.asset(
                                              "assets/images/music_on.png",
                                              height: 60,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Image.asset(
                        "assets/images/settings.png",
                        height: 90,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        provider.stopGlobalMusic();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BrickBreakerGameScreen(),
                            ));
                      },
                      child: Image.asset(
                        "assets/images/play.png",
                        height: 120,
                      ),
                    ),
                    Image.asset(
                      "assets/images/buy.png",
                      height: 90,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
