import 'package:orders_accountant/core/constants/common_libs.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final String error;

  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.error = '',
  });

  @override
  Widget build(BuildContext context) {
    print('apptextfield error: $error');

    final borderColor = error.isNotEmpty ? colors.red : colors.periwinkleBlue;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
                controller: controller,
                onChanged: onChanged,
                cursorOpacityAnimates: false,
                decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: borderColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: borderColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: borderColor, width: 2),
                  ),
                  fillColor: colors.white,
                  filled: true,
                ),
                style: textStyles.body.semiBold.c(colors.steelGrey)),
          ),
          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                error,
                style: textStyles.bodySmall.c(colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
