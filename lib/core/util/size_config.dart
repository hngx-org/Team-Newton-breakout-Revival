import 'package:flutter/material.dart';

class SizeConfig {
  static double fromHeight(BuildContext context, double height) {
    double phoneHeight = MediaQuery.of(context).size.height;
    return (phoneHeight / 100) * height;
  }

  static double fromWidth(BuildContext context, double width) {
    double phoneWidth = MediaQuery.of(context).size.width;
    return (phoneWidth / 100) * width;
  }

  static double fontSize(BuildContext context, double size) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    if (phoneWidth < phoneHeight) return (phoneWidth / 100) * size;
    return (phoneHeight / 100) * size;
  }
}

// extension Sizes on double {
//   double get hp {
//     double phoneHeight = WidgetsBinding.instance.window.physicalSize.height;
//     return (phoneHeight / 100) * this;
//   }

//   double get wp {
//     double phoneWidth = MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
//     return (phoneWidth / 100) * this;
//   }

//   double get sp {
//     double phoneHeight =MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
//     double phoneWidth =MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
//     if (phoneWidth < phoneHeight) return (phoneWidth / 100) * this;
//     return (phoneHeight / 100) * this;
//   }
// }