import 'package:orders_accountant/core/constants/common_libs.dart';

enum AppTextFieldSize { normal, small }

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final String error;
  final String initialValue;
  final EdgeInsets padding;
  final TextInputType? keyboardType;
  final AppTextFieldSize size;

  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.error = '',
    this.initialValue = '',
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.keyboardType,
    this.size = AppTextFieldSize.normal,
  });

  @override
  Widget build(BuildContext context) {
    print('apptextfield error: $error');

    final borderColor = error.isNotEmpty ? colors.red : colors.periwinkleBlue;

    late double height;
    switch (size) {
      case AppTextFieldSize.normal:
        height = 45;
        break;
      case AppTextFieldSize.small:
        height = 35;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: height,
            padding: padding,
            child: TextFormField(
                keyboardType: keyboardType,
                initialValue: initialValue,
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
