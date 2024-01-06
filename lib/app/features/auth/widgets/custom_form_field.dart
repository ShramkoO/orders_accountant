import 'package:orders_accountant/core/constants/common_libs.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final IconData icon;
  final bool obscureText;
  const CustomFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.keyboardType,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 90, minHeight: 90),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.info),
            borderRadius: BorderRadius.circular(
              styles.corners.sm,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.info),
            borderRadius: BorderRadius.circular(
              styles.corners.sm,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.error),
            borderRadius: BorderRadius.circular(
              styles.corners.sm,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.error),
            borderRadius: BorderRadius.circular(
              styles.corners.sm,
            ),
          ),
          // hintText: hintText,
          filled: true,
          fillColor: colors.info.withOpacity(0.2),
          prefixIcon: Container(
            width: 44,
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(width: 0.2))),
            child: Icon(
              icon,
              color: colors.info,
              size: 24,
            ),
          ),
        ),
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }
}
