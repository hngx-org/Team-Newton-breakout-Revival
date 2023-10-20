import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:newton_breakout_revival/data/global_provider/global_provider.dart';
import 'package:newton_breakout_revival/data/physics/game_engine.dart';
import 'package:newton_breakout_revival/presentation/widgets/countdown_timer.dart';
import 'package:newton_breakout_revival/presentation/widgets/neon_border_container.dart';
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
    return WillPopScope(
      onWillPop: () async {
        final p = Provider.of<GlobalProvider>(context, listen: false);
        p.playGlobalMusic();

        game.gamePaused = true;
        game.pauseEngine();
        p.update();
        bool data = false;
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Game paused"),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        game.gamePaused = false;

                        game.resumeEngine();
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('Continue'),
                    ),
                    TextButton(
                      onPressed: () {
                        data = true;
                        game.gamePaused = false;
                        p.live = 3;
                        p.score = 0;
                        game.resumeEngine();
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Exit'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        if (data) {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        body: Consumer<GlobalProvider>(builder: (context, provider, _) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      gradient: LinearGradient(
                          colors: [
                            Colors.green.shade900,
                            Colors.black,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
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
                                SizedBox(
                                  width: 100,
                                  child: CountdownTimer(
                                    remainingSeconds:
                                        provider.largePaddle.remainingSeconds,
                                    color: Colors.yellow,
                                  ),
                                ),
                                const Gap(10),
                                const Text(
                                  "Large Pad.",
                                  overflow: TextOverflow.ellipsis,
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
                                SizedBox(
                                  width: 100,
                                  child: CountdownTimer(
                                    remainingSeconds:
                                        provider.bigBall.remainingSeconds,
                                    color: Colors.blue,
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
                            const Gap(3),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: CountdownTimer(
                                    remainingSeconds:
                                        provider.shield.remainingSeconds,
                                    color: Colors.red,
                                  ),
                                ),
                                const Gap(10),
                                const Text(
                                  "Shield",
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
                              child: provider.live < 0
                                  ? Container()
                                  : ListView.builder(
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
                            const Gap(10),
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
                            const Gap(5),
                            InkWell(
                                onTap: () async {
                                  game.gamePaused = true;
                                  game.pauseEngine();
                                  provider.update();
                                  bool data = false;
                                  await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return WillPopScope(
                                        onWillPop: () async => false,
                                        child: Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text("Game paused"),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  game.gamePaused = false;

                                                  game.resumeEngine();
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const Text('Continue'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  data = true;
                                                  game.gamePaused = false;
                                                  provider.live = 3;
                                                  provider.score = 0;
                                                  game.resumeEngine();
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: const Text('Exit'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  if (data) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                  ),
                                ))
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
      ),
    );
  }
}
