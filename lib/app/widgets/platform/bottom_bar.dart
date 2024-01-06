import 'package:cuckoo_starter_kit/app/widgets/app_scaffold.dart';
import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
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
    return NavigationBar(
      elevation: 1,
      selectedIndex: selectedIndex,
      destinations: items,
      onDestinationSelected: onSelected,
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
          .map((t) => BottomNavigationBarItem(
              icon: t.icon, label: t.label, activeIcon: t.selectedIcon))
          .toList(),
      currentIndex: selectedIndex,
      onTap: onSelected,
    );
  }
}
