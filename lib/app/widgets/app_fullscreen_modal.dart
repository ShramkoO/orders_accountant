import 'dart:io';
import 'dart:ui';

import 'package:orders_accountant/core/constants/common_libs.dart';

class AppFullscreenModal extends StatelessWidget {
  const AppFullscreenModal({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool enableBlur = Platform.isIOS;

    return AlertDialog(
      backgroundColor: colors.greyMedium.withOpacity(0.4),
      contentPadding: EdgeInsets.zero,
      insetPadding:
          const EdgeInsets.only(left: 8, right: 8, top: 50, bottom: 20),
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: wrapIntoBlur(
              enableBlur: enableBlur,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colors.greyMedium.withOpacity(enableBlur ? 0.4 : 1),
                  border: Border.all(color: colors.greyMedium.withOpacity(0.4)),
                ),
                width: MediaQuery.of(context).size.width,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget wrapIntoBlur({required bool enableBlur, required Widget child}) {
  if (enableBlur) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: child,
    );
  } else {
    return child;
  }
}
