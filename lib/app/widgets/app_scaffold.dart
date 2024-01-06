import '../../core/constants/common_libs.dart';

// Scaffold used for every screen
class AppScaffold extends StatefulWidget {
  final Widget? body;
  final String? pageKey;
  final bool hasBottomNavigation;
  final StatefulNavigationShell? navigationShell;
  const AppScaffold({
    this.body,
    this.pageKey,
    this.hasBottomNavigation = false,
    this.navigationShell,
    super.key,
  }) : assert((body == null) != (navigationShell == null));

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final tabs = <AppNavigationItem>[
    AppNavigationItem(
      icon: const Icon(Icons.home),
      label: 'Home',
      location: ScreenPaths.home,
    ),
    AppNavigationItem(
      icon: const Icon(Icons.info),
      label: 'Info',
      location: ScreenPaths.info,
    ),
    AppNavigationItem(
      icon: const Icon(Icons.settings),
      label: 'Settings',
      location: ScreenPaths.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widgets.createBottomBar().render(
            selectedIndex: widget.navigationShell!.currentIndex,
            items: tabs,
            onSelected: (i) {
              widget.navigationShell!.goBranch(i);
            },
          ),
      body: widget.navigationShell,
      resizeToAvoidBottomInset: false,
    );
  }
}

// Custom BottomNavigationBarItem implementation to allow for named routes
class AppNavigationItem extends NavigationDestination {
  final String location;
  const AppNavigationItem(
      {super.key,
      required this.location,
      required super.icon,
      required super.label});
}
