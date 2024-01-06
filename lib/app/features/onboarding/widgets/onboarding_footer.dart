import 'package:orders_accountant/main.dart';
import 'package:orders_accountant/app/features/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  final OnboardingPageModel page;
  const OnboardingFooter({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(styles.insets.sm),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(styles.corners.sm),
      ),
      child: page.footer,
    );
  }
}
