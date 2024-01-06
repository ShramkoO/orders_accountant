import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter/cupertino.dart';

abstract interface class ISwitch {
  Widget render({required bool value, required Function(bool?) onChanged});
}

class AndroidSwitch implements ISwitch {
  const AndroidSwitch();

  @override
  Widget render({required bool value, required Function(bool?) onChanged}) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: colors.accent1,
      inactiveThumbColor: colors.black,
      inactiveTrackColor: colors.greyLight,
    );
  }
}

class IosSwitch implements ISwitch {
  const IosSwitch();

  @override
  Widget render({required bool value, required Function(bool?) onChanged}) {
    return CupertinoSwitch(value: value, onChanged: onChanged);
  }
}
