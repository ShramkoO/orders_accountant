import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

abstract interface class ITextField {
  Widget render({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?)? validator,
    TextInputType inputType = TextInputType.text,
    bool obscureText = false,
    String? label,
  });
}

class AndroidTextField implements ITextField {
  const AndroidTextField();

  @override
  Widget render({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?)? validator,
    TextInputType inputType = TextInputType.text,
    bool obscureText = false,
    String? label,
  }) {
    Widget formField = TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: styles.insets.sm),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.info),
          borderRadius: BorderRadius.circular(
            styles.corners.lg,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.info),
          borderRadius: BorderRadius.circular(
            styles.corners.lg,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.error),
          borderRadius: BorderRadius.circular(
            styles.corners.lg,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.error),
          borderRadius: BorderRadius.circular(
            styles.corners.lg,
          ),
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: inputType,
      validator: validator,
      obscureText: obscureText,
    );
    if (validator != null) {
      formField = ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 70, minHeight: 70),
        child: formField,
      );
    }
    if (label != null) {
      formField = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(label), Gap(styles.insets.xs), formField],
      );
    }
    return formField;
  }
}

class IosTextField implements ITextField {
  const IosTextField();

  @override
  Widget render({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?)? validator,
    TextInputType inputType = TextInputType.text,
    bool obscureText = false,
    String? label,
  }) {
    return CupertinoTextFormFieldRow(
      decoration: BoxDecoration(
        border: Border.all(color: colors.greyMedium),
        borderRadius: BorderRadius.circular(styles.corners.lg),
      ),
      placeholder: hintText,
      padding: EdgeInsets.all(styles.insets.sm),
      validator: validator,
      keyboardType: inputType,
      controller: controller,
      obscureText: obscureText,
    );
  }
}
