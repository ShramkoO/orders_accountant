import 'package:cuckoo_starter_kit/main.dart';
import 'package:cuckoo_starter_kit/app/widgets/controls/buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// Helper function to show the modals
Future<bool?> showModal(BuildContext context, {required Widget child}) async {
  return await showModalBottomSheet(
        context: context,
        builder: (_) => child,
      ) ??
      false;
}

class OkModal extends StatelessWidget {
  const OkModal({Key? key, this.title, this.msg}) : super(key: key);
  final String? title;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      buttons: [
        AppButton.from(
            text: strings.appModalsButtonOk,
            expand: true,
            onPressed: () => Navigator.of(context).pop(true)),
      ],
    );
  }
}

class OkCancelModal extends StatelessWidget {
  const OkCancelModal({Key? key, this.title, this.msg}) : super(key: key);
  final String? title;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      buttons: [
        Expanded(
          child: AppButton.from(
              text: strings.appModalsButtonCancel,
              expand: true,
              onPressed: () => Navigator.of(context).pop(false)),
        ),
        Gap(styles.insets.md),
        Expanded(
          child: AppButton.from(
              text: strings.appModalsButtonOk,
              expand: true,
              onPressed: () => Navigator.of(context).pop(true)),
        ),
      ],
    );
  }
}

class _BaseContentModal extends StatelessWidget {
  final String? title;
  final String? msg;
  final List<Widget> buttons;

  const _BaseContentModal(
      {Key? key, this.title, this.msg, required this.buttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(styles.insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) Text(title!, style: styles.text.header),
          Gap(styles.insets.sm),
          if (msg != null) Text(msg!),
          Gap(styles.insets.md),
          Row(children: buttons.map((e) => e).toList())
        ],
      ),
    );
  }
}
