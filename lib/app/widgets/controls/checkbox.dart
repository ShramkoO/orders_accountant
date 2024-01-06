import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';

import '../../../core/utils/helpers/app_haptics.dart';

class SimpleCheckbox extends StatelessWidget {
  const SimpleCheckbox(
      {Key? key,
      required this.active,
      required this.onToggled,
      required this.label})
      : super(key: key);
  final bool active;
  final String label;
  final Function(bool? onToggle) onToggled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: textStyles.bodySmall),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(styles.corners.sm)),
          ),
          child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(styles.corners.sm))),
              value: active,
              visualDensity:
                  const VisualDensity(horizontal: 0.1, vertical: 0.1),
              checkColor: colors.black.withOpacity(0.75),
              activeColor: colors.accent1.withOpacity(0.75),
              onChanged: (bool? active) {
                AppHaptics.mediumImpact();
                onToggled.call(active);
              }),
        ),
      ],
    );
  }
}
