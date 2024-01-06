import 'package:cuckoo_starter_kit/app/widgets/controls/buttons.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants/common_libs.dart';

abstract interface class INavigationBar {
  PreferredSizeWidget render({required String title});
}

class AndroidNavigationBar implements INavigationBar {
  const AndroidNavigationBar();

  @override
  PreferredSizeWidget render({required String title}) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        // We can also style the status bar in here, but without access to the elevation property
        statusBarColor: Colors.transparent,
      ),
      title: Text(title, style: textStyles.title),
      centerTitle: true,
      // foregroundColor: colors.black,
      elevation: 0,
      scrolledUnderElevation: 1,
    );
  }
}

class IosNavigationBar implements INavigationBar {
  const IosNavigationBar();

  @override
  PreferredSizeWidget render({required String title}) {
    return CupertinoNavigationBar(
      brightness: Brightness.dark,
      middle: Text(title, style: textStyles.title),
      padding: EdgeInsetsDirectional.zero,
    );
  }
}
