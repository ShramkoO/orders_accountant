import 'package:orders_accountant/core/constants/common_libs.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const AppTextField({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colors.periwinkleBlue, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colors.periwinkleBlue, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colors.periwinkleBlue, width: 2),
            ),
            fillColor: colors.white,
            filled: true,
          ),
          style: textStyles.body.semiBold.c(colors.steelGrey)),
    );
  }
}
