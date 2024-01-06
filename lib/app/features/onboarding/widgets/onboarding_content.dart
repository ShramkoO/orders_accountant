import 'package:orders_accountant/main.dart';
import 'package:orders_accountant/app/features/onboarding/widgets/onboarding_page.dart';
import 'package:orders_accountant/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingPageModel page;
  const OnboardingContent({super.key, required this.page});

  Widget _build(Widget? widget, String? text, TextStyle? style) {
    return widget ?? Text(text!, style: style);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(styles.insets.sm),
      padding: EdgeInsets.all(styles.insets.sm),
      child: Column(
        children: [
          _build(page.titleWidget, page.title, textStyles.title.bold),
          Gap(styles.insets.sm),
          _build(page.bodyWidget, page.body, textStyles.body),
        ],
      ),
    );
  }
}
