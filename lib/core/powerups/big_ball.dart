import 'dart:async';

import 'package:flutter/material.dart';

class BigBall {
  Timer? _timer;
  int _remainingSeconds = 0;
  final int _initialDuration = 10;

  bool get isActive => _timer ==  null ? false : _timer!.isActive;

  int get remainingSeconds => _remainingSeconds;

  void activate(Function() onEnd, {
    required VoidCallback onChanged 
  }) {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer?.cancel();
      }
    }

    _remainingSeconds = _initialDuration;
    _startTimer(
      () {
        onEnd();
      },
      () {
        onChanged();
      },
    );
  }

  void _startTimer(Function() onEnd, VoidCallback onChanged) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        onChanged();
      } else {
        timer.cancel();
        onEnd();
      }
    });
  }

  void cancel() {
    _timer?.cancel();
    _remainingSeconds = 0;
  }
}
