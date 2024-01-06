import 'package:cuckoo_starter_kit/main.dart';
import 'package:cuckoo_starter_kit/app/widgets/controls/buttons.dart';
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const OnboardingButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppButton.from(
      onPressed: onPressed ?? () {},
      text: text,
      bgColor: Colors.transparent,
      textStyle: TextStyle(color: colors.accent1, fontWeight: FontWeight.bold),
    );
  }
}
