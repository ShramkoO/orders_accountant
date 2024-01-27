import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter/cupertino.dart';

class AppColors {
  // Custom colors
  final Color greyLight = const Color(0xFFE6E6E6);
  final Color greyMedium = const Color(0xFFD7D6D8);
  final Color white = const Color(0xFFFFFFFF);
  final Color black = const Color(0xFF151022);
  final Color darkBlueGray = const Color(0xFF696988);
  final Color independence = const Color(0xFF514E67);

  final Color red = const Color(0xFFFF395A);

  //colors from Figma, chat gpt named them
  final Color steelGrey = const Color(0xFF696988);
  final Color midnightBlue = const Color(0xFF151022);
  final Color lavenderGrey = const Color(0xFFD3CAED);
  final Color pureWhite = const Color(0xFFFFFFFF);
  final Color periwinkleBlue = const Color(0xFF9494BA);
  final Color darkSlateBlue = const Color(0xFF152436);
  final Color jetBlack = const Color(0xFF000000);
  final Color slateGrey = const Color(0xFF514E67);
  final Color lightGrey = const Color(0xFFD7D6D8);
  final Color dustyPurple = const Color(0xFF886986);
  final Color oliveDrab = const Color(0xFF887969);
  final Color semiTransparentGrey = const Color(0xCCD7D6D8);

  // Theme colors
  late final Color accent1 = steelGrey;
  late final Color accent2 = slateGrey;
  late final Color body = white;
  late final Color bodyDark = black;

  // Snackbar colors
  final Color error = Colors.red.shade400;
  final Color success = Colors.green.shade400;
  final Color warning = Colors.yellow.shade400;
  final Color info = Colors.blueGrey.shade400;

  ThemeData toThemeData({required bool isDark}) {
    TextTheme txtTheme = (isDark
            ? ThemeData.dark(useMaterial3: true)
            : ThemeData.light(useMaterial3: true))
        .textTheme;
    Color bodyColor = isDark ? bodyDark : body;
    Color txtColor = isDark ? white : black;
    ColorScheme colorScheme = ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: accent1,
      primaryContainer: accent1,
      secondary: accent1,
      secondaryContainer: accent1,
      background: bodyColor,
      surface: bodyColor,
      onBackground: txtColor,
      onSurface: txtColor,
      onError: txtColor,
      onPrimary: white,
      onSecondary: white,
      error: error,
    );

    var t = ThemeData.from(
      textTheme: txtTheme,
      colorScheme: colorScheme,
    ).copyWith(
      textSelectionTheme: TextSelectionThemeData(cursorColor: accent1),
      highlightColor: accent1,
      useMaterial3: true,
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        textTheme: const CupertinoTextThemeData(),
        barBackgroundColor: CupertinoColors.systemGrey6,
      ),
    );

    return t;
  }
}
