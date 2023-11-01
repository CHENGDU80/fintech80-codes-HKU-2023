import 'package:flutter/material.dart';

class MyColors {
  static Color background = const Color(0xffffffff);
  static Color primary = const Color(0xffF2F2F2);
  static Color light = const Color(0xff1c407a);
}

class MyGradient {
  static const main = LinearGradient(
    colors: [
      Color(0xff2B7DDE),
      Color(0xff831BEA),
    ],
    transform: GradientRotation(1.618),
  );
}
