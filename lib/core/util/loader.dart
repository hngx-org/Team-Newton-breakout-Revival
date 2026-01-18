import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader {
  Loader(this.context, {this.allowBackButton = false});
  final bool allowBackButton;
  final BuildContext context;

  void show() {
    unawaited(
      Navigator.push(
        context,
        PageRouteBuilder(
          fullscreenDialog: true,
          opaque: false,
          barrierColor: Colors.transparent,
          pageBuilder: (_, __, ___) {
            return ProgressLoader(allowBackButton: allowBackButton);
          },
        ),
      ),
    );
  }

  void close() {
    Navigator.pop(context);
  }
}

class ProgressLoader extends StatelessWidget {
  const ProgressLoader({super.key, this.allowBackButton = false});
  final bool allowBackButton;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: allowBackButton,
      child: const Scaffold(
        backgroundColor: Colors.black26,
        body: Center(
            child: SpinKitCubeGrid(
          size: 70,
          color: Color.fromARGB(249, 120, 65, 3),
        )),
      ),
    );
  }
}
