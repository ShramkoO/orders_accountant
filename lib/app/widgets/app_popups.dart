import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';

// Helper function to show the popups
Future<bool?> showPopup(BuildContext context, {required Widget child}) async {
  return await showDialog(
        context: context,
        builder: (_) => child,
      ) ??
      false;
}

class OkPopup extends StatelessWidget {
  const OkPopup({Key? key, this.title, this.msg, this.child}) : super(key: key);
  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BasePopup(
      title: title,
      text: msg,
      buttons: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(strings.appModalsButtonOk),
        ),
      ],
    );
  }
}

class OkCancelPopup extends StatelessWidget {
  const OkCancelPopup({Key? key, this.title, this.msg, this.child})
      : super(key: key);
  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BasePopup(
      title: title,
      text: msg,
      buttons: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(strings.appModalsButtonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(strings.appModalsButtonOk),
        ),
      ],
    );
  }
}

class _BasePopup extends StatelessWidget {
  final String? title;
  final Widget? content;
  final String? text;
  final List<Widget> buttons;

  const _BasePopup({
    this.title,
    this.content,
    required this.buttons,
    this.text,
  })  : assert(
          (title != null) || (content != null) || (text != null),
          'You must define either title, text or content',
        ),
        assert(((content == null) != (text == null)),
            'Don\'t pass both content and text.');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      content: text != null ? Text(text!) : content,
      actions: [...buttons.map((b) => b).toList()],
    );
  }
}
