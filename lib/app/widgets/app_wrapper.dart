import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:cuckoo_starter_kit/app/features/user_info/widgets/user_info_notifier.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // The app lives inside of this
    return UserInfoNotifier(
        child: DefaultTextStyle(
      style: styles.text.body,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: child,
      ),
    ));
  }
}
