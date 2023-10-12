import 'package:flutter/material.dart';

class MovingBall extends StatefulWidget {
  const MovingBall({super.key});

  @override
  State<MovingBall> createState() => _MovingBallState();
}

class _MovingBallState extends State<MovingBall> with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, -8),
      end: const Offset(
          0, 0), // Adjust this value for the desired vertical movement
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
                0,
                _animation.value.dy *
                    50), // Adjust the multiplier for the distance
            child: SizedBox(
              height: 50,
              width: 100,
              child: Image.asset('assets/images/default-ball.png'),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}