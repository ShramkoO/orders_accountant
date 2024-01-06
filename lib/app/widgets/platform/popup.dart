import 'package:orders_accountant/app/widgets/controls/buttons.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter/cupertino.dart';

abstract interface class IPopup {
  Future<bool> show({
    required BuildContext context,
    String? title,
    String? msg,
    bool showCancelButton = true,
    Widget? child,
  });

  Widget render({
    required void Function() onOk,
    void Function()? onCancel,
    String? title,
    String? msg,
    bool showCancelButton = true,
    Widget? child,
  });
}

class AndroidPopup implements IPopup {
  const AndroidPopup();

  @override
  Future<bool> show({
    required BuildContext context,
    String? title,
    String? msg,
    bool showCancelButton = true,
    Widget? child,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return render(
          title: title,
          child: child,
          msg: msg,
          onOk: () => Navigator.of(context).pop(true),
          onCancel: () => Navigator.of(context).pop(false),
        );
      },
    );
  }

  @override
  Widget render({
    required void Function() onOk,
    void Function()? onCancel,
    String? title,
    String? msg,
    bool showCancelButton = true,
    Widget? child,
  }) {
    return AlertDialog(
      title: Text('$title'),
      content: child ?? Text('$msg'),
      actions: [
        if (showCancelButton)
          AppButton.text(
            onPressed: onCancel ?? () {},
            text: 'Abbrechen',
          ),
        AppButton.filled(
          onPressed: onOk,
          text: 'OK',
        ),
      ],
    );
  }
}

class IosPopup implements IPopup {
  const IosPopup();

  @override
  Future<bool> show({
    required BuildContext context,
    String? title,
    String? msg,
    bool showCancelButton = true,
    Widget? child,
  }) async {
    return await showCupertinoDialog(
      context: context,
      builder: (context) {
        return render(
          title: title,
          child: child,
          msg: msg,
          onOk: () => Navigator.of(context).pop(true),
          onCancel: () => Navigator.of(context).pop(false),
        );
      },
    );
  }

  @override
  Widget render({
    required void Function() onOk,
    void Function()? onCancel,
    String? title,
    String? msg,
    bool showCancelButton = true,
    Widget? child,
  }) {
    return CupertinoAlertDialog(
      title: Text('$title'),
      content: child ?? Text('$msg'),
      actions: [
        if (showCancelButton)
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onCancel ?? () {},
            child: const Text('Abbrechen'),
          ),
        CupertinoDialogAction(
          onPressed: onOk,
          isDefaultAction: true,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
