import 'package:flutter/material.dart';
import 'package:im_animations/im_animations.dart';

class SurpriceAnimatedWidget extends StatelessWidget {
  const SurpriceAnimatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Rotate(
      rotationDirection: RotationDirection.clockwise,
      repeat: true,
      child: Container(
        color: Colors.white,
        child: Image.asset('assets/meridian.png'),
      ),
    );
  }
}
