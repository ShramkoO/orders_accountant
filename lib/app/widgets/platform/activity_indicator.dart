import 'package:flutter/cupertino.dart';

import '../../../core/constants/common_libs.dart';

abstract interface class IActivityIndicator {
  Widget render();
}

class AndroidActivityIndicator implements IActivityIndicator {
  const AndroidActivityIndicator();

  @override
  Widget render() {
    return const CircularProgressIndicator();
  }
}

class IosActivityIndicator implements IActivityIndicator {
  const IosActivityIndicator();

  @override
  Widget render() {
    return const CupertinoActivityIndicator();
  }
}
