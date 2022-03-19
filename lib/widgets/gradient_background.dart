import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.4,
            0.8,
            1
          ],
              colors: [
            Color(0xff1686C1),
            Color(0xff083F5C),
            Color.fromARGB(255, 2, 26, 39),
            // Colors.black
          ])),
      // height: 10,
    );
  }
}
