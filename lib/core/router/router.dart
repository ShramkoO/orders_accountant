import 'dart:async';
import 'package:orders_accountant/app/features/auth/screens/email_confirmed_screen.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/app/widgets/app_scaffold.dart';
import 'package:orders_accountant/app/features/onboarding/onboarding_screen.dart';
import 'package:orders_accountant/app/features/auth/screens/forgot_password_screen.dart';
import 'package:orders_accountant/app/features/auth/screens/new_password_screen.dart';
import 'package:orders_accountant/app/features/auth/screens/sign_in_screen.dart';
import 'package:orders_accountant/app/features/auth/screens/sign_up_screen.dart';
import 'package:orders_accountant/app/features/home/screens/home_screen.dart';
import 'package:orders_accountant/app/features/info/info_screen.dart';
import 'package:orders_accountant/app/features/settings/screens/settings_screen.dart';
import 'package:orders_accountant/app/features/startup/screens/startup_screen.dart';
import 'package:orders_accountant/app/widgets/page_scaffold.dart';
import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _authNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'auth');

// Add the route names here for safe acces throughout the app
class ScreenPaths {
  static String splash = StartupScreen.routeName;
  static String home = HomeScreen.routeName;
  static String info = InfoScreen.routeName;
  static String settings = SettingsScreen.routeName;
  static String signUp = SignUpScreen.routeName;
  static String signIn = SignInScreen.routeName;
  static String onboarding = OnboardingScreen.routeName;
  static String forgotPassword = ForgotPasswordScreen.routeName;
  static String newPassword = NewPasswordScreen.routeName;
  static String emailConfirmed = EmailConfirmedScreen.routeName;
}

// Add new AppRoutes here, using the Screenpaths above
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: _handleRedirect,
  initialLocation: ScreenPaths.home,
  routes: [
    ShellRoute(
      parentNavigatorKey: _rootNavigatorKey,
      navigatorKey: _authNavigatorKey,
      builder: (context, state, child) {
        return child;
      },
      routes: [
        AppRoute(
          ScreenPaths.splash,
          (_) => const StartupScreen(),
          hideAppBar: true,
        ),
        AppRoute(
          ScreenPaths.onboarding,
          (_) => const OnboardingScreen(),
          hideAppBar: true,
        ),
        AppRoute(
          ScreenPaths.signUp,
          (_) => const SignUpScreen(),
          title: 'Welcome',
        ),
        AppRoute(
          ScreenPaths.signIn,
          (_) => const SignInScreen(),
          title: 'Welcome back',
        ),
        AppRoute(
          ScreenPaths.newPassword,
          (_) => const NewPasswordScreen(),
          title: 'Set new password',
        ),
        AppRoute(
          ScreenPaths.forgotPassword,
          (_) => const ForgotPasswordScreen(),
          title: 'Forgot Password',
        ),
      ],
    ),
    AppRoute(
      ScreenPaths.emailConfirmed,
      (_) => const EmailConfirmedScreen(),
      title: 'E-Mail bestätigt',
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return AppScaffold(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(routes: [
          AppRoute(
            ScreenPaths.home,
            (_) => const HomeScreen(),
            title: 'Home',
          ),
        ]),
        StatefulShellBranch(
          routes: [
            AppRoute(
              ScreenPaths.info,
              (_) => const InfoScreen(),
              title: 'Info',
            ),
          ],
        ),
        StatefulShellBranch(routes: [
          AppRoute(
            ScreenPaths.settings,
            (_) => const SettingsScreen(),
            title: 'Settings',
          ),
        ]),
      ],
    ),
  ],
);

class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> routes = const [],
    this.useFade = true,
    String? Function(GoRouterState)? routeRedirect,
    this.hideAppBar = false,
    this.title,
  }) : super(
          // allows route specific redirects and guards
          redirect: _handleRedirect,
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = builder(state);

            return CupertinoPage(
              child: PageScaffold(
                body: pageContent,
                hideAppBar: hideAppBar ?? false,
                title: title ?? '',
              ),
            );
          },
        );

  final bool useFade;
  final String? title;
  final bool? hideAppBar;
}

// top level redirects and guards
// route level works the same way but needs to be specified inside of the approute
FutureOr<String?> _handleRedirect(BuildContext context, GoRouterState state) {
  // This would be handled through bloc or the authRepo
  // Only allow redirects if the app has finished loading
  if (!startupCubit.state.startupFinished &&
      state.uri.toString() != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }

  // returning null redirects the user to the requested page
  return null;
}
