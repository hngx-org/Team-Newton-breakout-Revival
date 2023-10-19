// import 'dart:async';

// class BigBall {
//   late Timer _timer;
//   int _remainingSeconds = 0;
//   final int _initialDuration = 15; // Initial duration in seconds

//   bool get isActive => _timer.isActive;

//   int get remainingSeconds => _remainingSeconds;

//   void activate() {
//     if (_timer.isActive) {
//       _timer.cancel();
//     }

//     _remainingSeconds = _initialDuration;
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingSeconds > 0) {
//         _remainingSeconds--;
//       } else {
//         timer.cancel();
        
//       }
//     });
//   }

//   void cancel() {
//     _timer.cancel();
//     _remainingSeconds = 0;
//   }
// }

