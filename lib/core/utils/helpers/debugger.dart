import 'package:flutter/foundation.dart';

void debugger(String? message) {
  if (kDebugMode) {
    print(message);
  }
}
