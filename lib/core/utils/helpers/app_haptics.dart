import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter/foundation.dart';

class AppHaptics {
  static void buttonPress() {
    // android expects feedback on every button press
    if (defaultTargetPlatform != TargetPlatform.android) {
      lightImpact();
    }
  }

  static Future<void> lightImpact() {
    return HapticFeedback.lightImpact();
  }

  static Future<void> mediumImpact() {
    return HapticFeedback.mediumImpact();
  }

  static Future<void> heavyImpact() {
    return HapticFeedback.heavyImpact();
  }

  static Future<void> selectionClick() {
    return HapticFeedback.selectionClick();
  }

  static Future<void> vibrate() {
    return HapticFeedback.vibrate();
  }
}
