import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:newton_breakout_revival/presentation/views/game/game_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(31, 23, 136, 192),
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
