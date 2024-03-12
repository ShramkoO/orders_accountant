//

import 'package:orders_accountant/core/constants/common_libs.dart';

class AppDropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final String Function(String) nameToDisplayName;

  final Function(String?)? onChanged;

  const AppDropdown(
      {super.key,
      required this.items,
      required this.selectedValue,
      required this.nameToDisplayName,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    print('AppDropdown build');
    print('selectedValue: $selectedValue');

    final dropdownBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: colors.periwinkleBlue,
        width: 1.5,
      ),
    );

    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8),
      //   border: Border.all(
      //     color: colors.periwinkleBlue,
      //     width: 1.5,
      //   ),
      //   color: colors.white,
      // ),
      child: InputDecorator(
        decoration: InputDecoration(
          border: dropdownBorder,
          enabledBorder: dropdownBorder,
          focusedBorder: dropdownBorder.copyWith(
            borderSide: BorderSide(
              color: colors.periwinkleBlue,
              width: 2,
            ),
          ),
          disabledBorder: dropdownBorder,
          fillColor: colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          filled: true,
        ),
        child: DropdownButtonHideUnderline(
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: colors.white,
            ),
            child: DropdownButton<String>(
              style: textStyles.body.c(colors.steelGrey),
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                color: colors.steelGrey,
              ),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(nameToDisplayName(value)),
                );
              }).toList(),
              onChanged: (newValue) {
                onChanged?.call(newValue);
              },
              value: selectedValue,
              iconSize: 24,
              elevation: 16,
            ),
          ),
        ),
      ),
    );
  }
}
