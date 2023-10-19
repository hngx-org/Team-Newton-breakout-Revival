import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  final int remainingSeconds;
  final Color color;

  const CountdownTimer(
      {super.key, required this.remainingSeconds, required this.color});

  @override
  Widget build(BuildContext context) {
    final progress = remainingSeconds / 5;

    return LinearProgressIndicator(
      value: progress,
      valueColor: AlwaysStoppedAnimation(color), // Customize the color
      backgroundColor: Colors.grey, // Customize the background color
    );
  }
}
