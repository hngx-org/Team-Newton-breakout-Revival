import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:newton_breakout_revival/Leadershipbord/leadership.dart';
import 'package:newton_breakout_revival/auth/login_screen.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/presentation/animation/moving_ball.dart';
import 'package:newton_breakout_revival/presentation/animation/moving_paddle.dart';
import 'package:newton_breakout_revival/presentation/views/game/game_view.dart';
import 'package:newton_breakout_revival/presentation/views/leaderboard/leaderboard.dart';
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
          Center(
            child: Text(
              'Highest Score: ${provider.score}',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Minecraft',
                fontSize: 25,
              ),
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
                              child:
                                  StatefulBuilder(builder: (context, update) {
                                return Container(
                                  width: 400,
                                  height: 400,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      scale: 0.1,
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        "assets/images/settings_dialog.png",
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                provider.isSongPlaying =
                                                    !provider.isSongPlaying;

                                                if (provider.isSongPlaying) {
                                                  provider.playGlobalMusic();
                                                } else {
                                                  provider.stopGlobalMusic();
                                                }

                                                update(() {});
                                              },
                                              child: Image.asset(
                                                provider.isSongPlaying
                                                    ? "assets/images/song-on.png"
                                                    : "assets/images/song-off.png",
                                                height: 60,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            const LoginScreen()));
                                              },
                                              child: const Text('Login')),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          child: ElevatedButton(
                                              onPressed: () {},
                                              child: const Text('Logout')),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        );
                      },
                      child: Image.asset(
                        "assets/images/settings-blue.png",
                        height: 90,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LeaderboardDialog(),
                            ));
                      },
                      child: Image.asset(
                        "assets/images/leadership.png",
                        height: 110,
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
                        "assets/images/play-blue-2.png",
                        height: 120,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        provider.stopGlobalMusic();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LeaderboardScreen(),
                            ));
                      },
                      child: Image.asset(
                        "assets/images/leaderboard.png",
                        height: 90,
                      ),
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
