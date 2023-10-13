import 'package:flutter/material.dart';

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
