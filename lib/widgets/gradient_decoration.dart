import 'package:flutter/rendering.dart';

class GradientDecoration extends BoxDecoration {
  @override
  Gradient? get gradient => LinearGradient(stops: [
        0,
        .332,
        .6445,
        100
      ], colors: [
        Color.fromRGBO(255, 164, 28, 0.08),
        Color.fromRGBO(255, 58, 58, 0.08),
        Color.fromRGBO(53, 134, 255, 0.08),
        Color.fromRGBO(99, 26, 255, 0.08),
      ]);
}
