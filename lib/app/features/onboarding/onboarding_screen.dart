import 'dart:async';
import 'dart:math';

import 'package:orders_accountant/core/constants/assets.dart';
import 'package:orders_accountant/main.dart';
import 'package:orders_accountant/core/router/router.dart';
import 'package:orders_accountant/app/features/onboarding/widgets/onboarding_button.dart';
import 'package:orders_accountant/app/features/onboarding/widgets/onboarding_dots.dart';
import 'package:orders_accountant/app/features/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({
    super.key,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  double _currentPage = 0;
  final bool _isSkipped = false;
  bool _isScrolling = false;
  late ScrollController _scrollController;
  late List<OnboardingPageModel> pages;

  PageController get controler => _pageController;

  @override
  void initState() {
    super.initState();

    pages = [
      OnboardingPageModel(
        footer: Container(),
        title: 'Step 1',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent feugiat sodales purus et dapibus. Morbi mollis dui sit amet dolor volutpat dapibus. Nunc a lorem.',
        image: Image.asset(Assets.onboardingOne),
      ),
      OnboardingPageModel(
        footer: Container(),
        title: 'Step 2',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent feugiat sodales purus et dapibus. Morbi mollis dui sit amet dolor volutpat dapibus. Nunc a lorem.',
        image: Image.asset(Assets.onboardingTwo),
      ),
      OnboardingPageModel(
        footer: Container(),
        title: 'Step 3',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent feugiat sodales purus et dapibus. Morbi mollis dui sit amet dolor volutpat dapibus. Nunc a lorem.',
        image: Image.asset(Assets.onboardingThree),
      ),
      OnboardingPageModel(
        footer: Container(),
        title: 'Step 4',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent feugiat sodales purus et dapibus. Morbi mollis dui sit amet dolor volutpat dapibus. Nunc a lorem.',
        image: Image.asset(Assets.onboardingFour),
      ),
    ];

    _pageController = PageController(initialPage: 0);
    _scrollController = ScrollController();
    _currentPage = 0.0;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  int getCurrentPage() => _currentPage.round();

  void next() {
    animateScroll(getCurrentPage() + 1);
  }

  void previous() {
    animateScroll(getCurrentPage() - 1);
  }

  void done() {
    appRouter.go(ScreenPaths.signUp);
    settingsCubit.completeOnboarding();
  }

  Future<void> animateScroll(int page) async {
    _isScrolling = true;
    await _pageController.animateToPage(
      max(min(page, pages.length - 1), 0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    if (mounted) {
      _isScrolling = false;
    }
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics && metrics.page != null) {
      if (mounted) {
        setState(() => _currentPage = metrics.page!);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = (getCurrentPage() == pages.length - 1);
    Widget skipButton = Visibility(
      visible: !isLastPage && !_isSkipped,
      maintainState: true,
      maintainAnimation: true,
      child: OnboardingButton(
        text: 'Skip',
        onPressed: done,
      ),
    );
    Widget leftButton = OnboardingButton(
      text: 'Back',
      onPressed: !_isScrolling ? previous : null,
    );

    Widget rightButton;

    if (isLastPage) {
      rightButton = OnboardingButton(
        text: 'Done',
        onPressed: !_isScrolling ? done : null,
      );
    } else {
      rightButton = OnboardingButton(
        text: 'Next',
        onPressed: !_isScrolling ? next : null,
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: pages
                  .map(
                    (page) => OnboardingPage(
                      page: page,
                      scrollController: _scrollController,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: leftButton,
                  ),
                  Expanded(
                    child: Center(
                      child: OnboardingDots(
                        dotsCount: pages.length,
                        position: _currentPage,
                      ),
                    ),
                  ),
                  Expanded(
                    child: rightButton,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(top: 0, right: 0, child: skipButton),
      ],
    );
  }
}
