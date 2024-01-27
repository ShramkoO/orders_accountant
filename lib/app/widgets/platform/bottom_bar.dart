import 'package:orders_accountant/app/widgets/app_scaffold.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter/cupertino.dart';

abstract interface class IBottomBar {
  Widget render({
    required List<AppNavigationItem> items,
    required int selectedIndex,
    required Function(int) onSelected,
  });
}

class AndroidBottomBar implements IBottomBar {
  const AndroidBottomBar();

  @override
  Widget render({
    required List<AppNavigationItem> items,
    required int selectedIndex,
    required Function(int) onSelected,
  }) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) => states.contains(MaterialState.selected)
              ? TextStyle(
                  color: colors.lavenderGrey, fontWeight: FontWeight.w500)
              : TextStyle(color: colors.periwinkleBlue),
        ),
      ),
      child: NavigationBar(
        elevation: 1,
        selectedIndex: selectedIndex,
        destinations: items,
        onDestinationSelected: onSelected,
        height: 64,
      ),
    );
  }
}

class IosBottomBar implements IBottomBar {
  const IosBottomBar();

  @override
  Widget render({
    required List<AppNavigationItem> items,
    required int selectedIndex,
    required Function(int) onSelected,
  }) {
    return CupertinoTabBar(
      items: items
          .map(
            (AppNavigationItem navigationItem) => BottomNavigationBarItem(
              icon: navigationItem.icon,
              label: navigationItem.label,
              activeIcon: navigationItem.selectedIcon,
            ),
          )
          .toList(),
      activeColor: colors.lavenderGrey,
      currentIndex: selectedIndex,
      inactiveColor: colors.periwinkleBlue,
      onTap: onSelected,
      height: 64,
    );
  }
}
