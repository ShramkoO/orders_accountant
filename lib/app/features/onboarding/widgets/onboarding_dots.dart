import 'dart:math';

import 'package:orders_accountant/main.dart';
import 'package:flutter/material.dart';

class OnboardingDots extends StatelessWidget {
  final int dotsCount;
  final double position;
  const OnboardingDots({super.key, required this.dotsCount, this.position = 0});

  Widget _buildDot(BuildContext context, int index) {
    final double lerpValue = min(1, (position - index).abs().toDouble());

    final size = Size.lerp(
      const Size(20, 10),
      const Size.square(10),
      lerpValue,
    )!;
    final color = Color.lerp(
      colors.accent1,
      colors.greyMedium,
      lerpValue,
    )!;
    final shape = ShapeBorder.lerp(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      const CircleBorder(),
      lerpValue,
    )!;

    return Container(
      width: size.width,
      height: size.height,
      margin: const EdgeInsets.all(2),
      decoration: ShapeDecoration(
        color: color,
        shape: shape,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dots = List<Widget>.generate(dotsCount, (i) => _buildDot(context, i));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
  }
}
