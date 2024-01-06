// ignore_for_file: library_private_types_in_public_api

import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';

export 'colors.dart';

@immutable
class AppStyle {
  final AppColors colors = AppColors();

  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  late final _Insets insets = _Insets();

  late final _Text text = _Text();

  final _Times times = _Times();
}

@immutable
class _FontFamilies {
  static String get body => 'Roboto';
  static String get title => 'Roboto';
}

@immutable
class _FontSizes {
  static double get header => 28;
  static double get title => 24;
  static double get body => 16;
  static double get bodySmall => 12;
}

@immutable
class _Text {
  /// The biggest FontSize, used for main Headers
  /// Similar to how you would use an h1 in HTML
  TextStyle get header => TextStyle(
        fontFamily: _FontFamilies.title,
        fontSize: _FontSizes.header,
      );

  /// Used for various titles throughout the App
  TextStyle get title => TextStyle(
        fontFamily: _FontFamilies.title,
        fontSize: _FontSizes.title,
      );

  /// Main TextStyle for everything
  TextStyle get body => TextStyle(
        fontFamily: _FontFamilies.body,
        fontSize: _FontSizes.body,
      );

  /// Smaller TextStyle for labels etc.
  TextStyle get bodySmall => TextStyle(
        fontFamily: _FontFamilies.body,
        fontSize: _FontSizes.bodySmall,
      );
}

extension TextStyleHelpers on TextStyle {
  /// The same TextStyle but bold
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  /// The same TextStyle but italic
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// The same TextStyle but in a different Color
  TextStyle c(Color color) => copyWith(color: color);
}

@immutable
class _Times {
  // Consistent animation times throughout the app
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
}

@immutable
class _Corners {
  // Consistent corner radii throughout the app
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

@immutable
class _Insets {
  // Consistent spacing throughout the app
  late final double body = 24;
  late final double xxs = 2;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double offset = 80;
}

@immutable
class _Shadows {
  // Consistent shadows throughout the app
  final textSoft = [
    Shadow(
        color: Colors.black.withOpacity(.25),
        offset: const Offset(0, 2),
        blurRadius: 4),
  ];
  final text = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 2),
        blurRadius: 2),
  ];
  final textStrong = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 4),
        blurRadius: 6),
  ];
}
