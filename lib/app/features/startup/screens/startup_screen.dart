import 'package:orders_accountant/app/features/auth/cubit/auth_cubit.dart';
import 'package:orders_accountant/core/constants/assets.dart';
import 'package:orders_accountant/main.dart';
import 'package:orders_accountant/core/router/router.dart';
import 'package:flutter/material.dart';

class StartupScreen extends StatefulWidget {
  static const String routeName = '/';
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double turns = 0.0;

  String _imgUrl = Assets.cuckoo;

  Future<void> _blink() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() => _imgUrl = Assets.cuckooBlink);
    });
    await Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _imgUrl = Assets.cuckoo);
    });
    await Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _imgUrl = Assets.cuckooBlink);
    });
    await Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _imgUrl = Assets.cuckoo);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    if (!startupCubit.state.startupFinished) {
      _controller.forward();
      _blink();

      Future.wait([
        startupCubit.initialStartup,
        Future.delayed(const Duration(seconds: 2)),
      ]).then((responses) {
        startupCubit.finishStartup();
        if (authCubit.state is PasswordRecovery) {
          appRouter.go(ScreenPaths.newPassword);
        } else if (authCubit.state is Authenticated) {
          appRouter.go(ScreenPaths.home);
        } else {
          if (settingsCubit.state.hasCompletedOnboarding) {
            appRouter.go(ScreenPaths.signUp);
          } else {
            appRouter.go(ScreenPaths.onboarding);
          }
        }
      }).catchError((e) {
        appRouter.go(ScreenPaths.signUp);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ScaleTransition(
      scale: _animation,
      child: SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            _imgUrl,
            gaplessPlayback: true,
          )),
    ));
  }
}
