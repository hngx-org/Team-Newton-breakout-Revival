import 'package:flutter/material.dart';

class MovingPaddle extends StatefulWidget {
  const MovingPaddle({Key? key}) : super(key: key);

  @override
  State<MovingPaddle> createState() => _MovingPaddleState();
}

class _MovingPaddleState extends State<MovingPaddle>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _horizontalAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Horizontal movement animation
    _horizontalAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Start from the left side
      end: const Offset(1, 0), // End at the right side
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
              _horizontalAnimation.value.dx *
                  200, // Adjust the horizontal movement distance
              0,
            ),
            child: SizedBox(
              height: 20,
              width: 100,
              child: Image.asset('assets/images/default-player.png'),
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
