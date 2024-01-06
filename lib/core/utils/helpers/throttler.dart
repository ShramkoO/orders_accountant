import 'dart:async';

import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';

class Throttler {
  final Duration interval;
  Throttler(this.interval);

  VoidCallback? _callback;
  Timer? _timer;

  void call(VoidCallback callback, {bool callImmediately = true}) {
    _callback = callback;

    if (_timer == null) {
      if (callImmediately) {
        _callAction();
      }
      _timer = Timer(interval, _callAction);
    }
  }

  void _callAction() {
    _callback?.call();
    _timer = null;
  }

  void reset() {
    _callback = null;
    _timer = null;
  }
}
