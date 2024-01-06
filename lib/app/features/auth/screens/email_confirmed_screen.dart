import 'package:animated_check/animated_check.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';

class EmailConfirmedScreen extends StatefulWidget {
  static const routeName = '/confirm-email';
  const EmailConfirmedScreen({super.key});

  @override
  State<EmailConfirmedScreen> createState() => _EmailConfirmedScreenState();
}

class _EmailConfirmedScreenState extends State<EmailConfirmedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.forward();
      Future.delayed(const Duration(seconds: 3), () {
        appRouter.go(ScreenPaths.home);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedCheck(
        progress: _animation,
        size: 200,
        color: colors.success,
      ),
    );
  }
}
