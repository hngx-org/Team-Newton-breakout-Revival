// ignore_for_file: use_build_context_synchronously

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:newton_breakout_revival/core/util/size_config.dart';
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
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Game paused",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Minecraft',
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          game.gamePaused = false;

                          game.resumeEngine();
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Minecraft',
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
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
                        child: const Text(
                          'Exit',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Minecraft',
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ],
                  ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: SizeConfig.fromWidth(context, 20),
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
                              Row(
                                children: [
                                  SizedBox(
                                    width: SizeConfig.fromWidth(context, 20),
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
                              Row(
                                children: [
                                  SizedBox(
                                    width: SizeConfig.fromWidth(context, 20),
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
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: SizeConfig.fromWidth(context, 17),
                                child: provider.live < 0
                                    ? Container()
                                    : ListView.builder(
                                        itemCount: provider.live,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Icon(
                                            Icons.favorite_rounded,
                                            size:
                                                SizeConfig.fontSize(context, 5),
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                              ),
                              Text(
                                'Score ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.fontSize(context, 3),
                                  fontFamily: 'Minecraft',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(5),
                              NeonBorderContainer(
                                width: SizeConfig.fromWidth(context, 10),
                                height: SizeConfig.fromWidth(context, 10),
                                child: Center(
                                  child: Text(
                                    "${provider.score}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: SizeConfig.fontSize(context, 4),
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
                                            backgroundColor: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    "Game paused",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Minecraft',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
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
                                                    child: const Text(
                                                      'Continue',
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontFamily:
                                                              'Minecraft',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25),
                                                    ),
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
                                                    child: const Text(
                                                      'Exit',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontFamily:
                                                              'Minecraft',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
