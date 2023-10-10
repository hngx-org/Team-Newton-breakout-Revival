// ignore_for_file: use_build_context_synchronously

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/brick_breaker_game.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  void initState() {
    _leaveLoading();
    print("Move to game");
    super.initState();
  }

  _leaveLoading() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BrickBreakerGameScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSft6L-xTotXiMz8SCOpszx8uedXDw6dS0vHw&usqp=CAU"),
              fit: BoxFit.scaleDown),
          gradient: RadialGradient(
            colors: [
              Colors.green.shade500.withOpacity(0.8),
              Colors.green.shade900.withOpacity(0.8),
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
                const Text(
                  "Breakout\nRevival",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50, fontFamily: 'Game', color: Colors.white),
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.yellow.shade900, width: 4),
                      gradient: LinearGradient(
                          colors: [
                            Colors.green.shade500,
                            Colors.green.shade900,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Minecraft',
                          color: Colors.white),
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

class BrickBreakerGameScreen extends StatefulWidget {
  const BrickBreakerGameScreen({super.key});

  @override
  State<BrickBreakerGameScreen> createState() => _BrickBreakerGameScreenState();
}

class _BrickBreakerGameScreenState extends State<BrickBreakerGameScreen> {
  late BrickBreakerGame game;
  bool gameStarted = false;
  @override
  void initState() {
    super.initState();
    game = BrickBreakerGame(
      context,
      gameStarted: gameStarted,
    ); // Pass gameStarted to the game instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: game,
            backgroundBuilder: (context) {
              return const Center(
                child: Opacity(
                  opacity: 0.3,
                  child: FlutterLogo(
                    size: 350,
                  ),
                ),
              );
            },
          ),
          if (!gameStarted)
            {
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button tap to start the game.
                    game.startGame(); // Call the startGame method in BrickBreakerGame
                    setState(() {
                      gameStarted = true; // Update the game state
                    });
                  },
                  child: const Text(
                    "Start Game",
                  ),
                ),
              )
            }.first,
        ],
      ),
    );
  }
}
