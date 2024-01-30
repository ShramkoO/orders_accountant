import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:gap/gap.dart';

class InfoScreen extends StatefulWidget {
  // Every Screen should have a routeName, for safe access in the router
  static const String routeName = '/info';
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // final AndroidWidgetsFactory _a = const AndroidWidgetsFactory();
  // final IosWidgetsFactory _i = const IosWidgetsFactory();

  bool switchValue = false;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(styles.insets.body),
      child: ListView(
        children: [
          // ExpansionTile(
          //   title: Text('Buttons'),
          //   children: [
          //     WidgetPreview(
          //       text: 'AppButton.text()',
          //       widget: AppButton.text(
          //         text: 'Button',
          //         onPressed: () {},
          //       ),
          //     ),
          //     WidgetPreview(
          //       text: 'AppButton.filled()',
          //       widget: AppButton.filled(
          //         text: 'Button',
          //         onPressed: () {},
          //       ),
          //     ),
          //     WidgetPreview(
          //       text: 'AppButton.icon()',
          //       widget: AppButton.icon(
          //         icon: Icon(Icons.ads_click),
          //         semanticLabel: 'Button',
          //         onPressed: () {},
          //       ),
          //     ),
          //     WidgetPreview(
          //       text: 'AppButton.from()',
          //       widget: AppButton.from(
          //         text: 'Button',
          //         expand: true,
          //         onPressed: () {},
          //       ),
          //     ),
          //   ],
          // ),
          // ExpansionTile(
          //   title: Text('Platform Widgets: Android'),
          //   children: [
          //     WidgetPreview(
          //       text: 'Activity Indicator',
          //       widget: _a.createActivityIndicator().render(),
          //     ),
          //     WidgetPreview(
          //       text: 'Bottom Bar',
          //       widget: _a.createBottomBar().render(
          //         items: const [
          //           AppNavigationItem(
          //             icon: Icon(Icons.home),
          //             label: 'Home',
          //             location: '',
          //           ),
          //           AppNavigationItem(
          //             icon: Icon(Icons.dashboard),
          //             label: 'Dashboard',
          //             location: '',
          //           ),
          //           AppNavigationItem(
          //             icon: Icon(Icons.search),
          //             label: 'Search',
          //             location: '',
          //           ),
          //           AppNavigationItem(
          //             icon: Icon(Icons.settings),
          //             label: 'Settings',
          //             location: '',
          //           ),
          //         ],
          //         selectedIndex: 0,
          //         onSelected: (_) {},
          //       ),
          //     ),
          //     WidgetPreview(
          //       text: 'Navigation Bar',
          //       widget: _a.createNavigationBar().render(title: 'Navbar'),
          //     ),
          //     WidgetPreview(
          //       text: 'Popup',
          //       widget: _a.createPopup().render(
          //             title: 'Popup',
          //             msg: 'This is a popup',
          //             onOk: () {},
          //           ),
          //     ),
          //     WidgetPreview(
          //       text: 'Switch',
          //       widget: _a.createSwitch().render(
          //             value: switchValue,
          //             onChanged: (v) => setState(() => switchValue = v!),
          //           ),
          //     ),
          //     WidgetPreview(
          //       text: 'TextField',
          //       widget: _a.createTextField().render(
          //             controller: textEditingController,
          //             hintText: 'Text',
          //             validator: (v) => v,
          //           ),
          //     ),
          //     WidgetPreview(
          //       text: 'TimePicker',
          //       widget: SizedBox(
          //         width: 200,
          //         height: 150,
          //         child: _a.createTimePicker().render(
          //               startTime: TimeOfDay.now(),
          //               onChanged: (v) {},
          //             ),
          //       ),
          //     ),
          //   ],
          // ),
          // ExpansionTile(
          //   title: Text('Platform Widgets: iOS'),
          //   children: [
          //     WidgetPreview(
          //       text: 'Activity Indicator',
          //       widget: _i.createActivityIndicator().render(),
          //     ),
          //     WidgetPreview(
          //       text: 'Bottom Bar',
          //       widget: _i.createBottomBar().render(
          //         items: const [
          //           AppNavigationItem(
          //             icon: Icon(Icons.home),
          //             label: 'Home',
          //             location: '',
          //           ),
          //           AppNavigationItem(
          //             icon: Icon(Icons.dashboard),
          //             label: 'Dashboard',
          //             location: '',
          //           ),
          //           AppNavigationItem(
          //             icon: Icon(Icons.search),
          //             label: 'Search',
          //             location: '',
          //           ),
          //           AppNavigationItem(
          //             icon: Icon(Icons.settings),
          //             label: 'Settings',
          //             location: '',
          //           ),
          //         ],
          //         selectedIndex: 0,
          //         onSelected: (_) {},
          //       ),
          //     ),
          //     WidgetPreview(
          //       text: 'Navigation Bar',
          //       widget: _i.createNavigationBar().render(title: 'Navbar'),
          //     ),
          //     WidgetPreview(
          //       text: 'Popup',
          //       widget: _i.createPopup().render(
          //             title: 'Popup',
          //             msg: 'This is a popup',
          //             onOk: () {},
          //           ),
          //     ),
          //     WidgetPreview(
          //       text: 'Switch',
          //       widget: _i.createSwitch().render(
          //             value: switchValue,
          //             onChanged: (v) => setState(() => switchValue = v!),
          //           ),
          //     ),
          //     WidgetPreview(
          //       text: 'TextField',
          //       widget: _i.createTextField().render(
          //             controller: textEditingController,
          //             hintText: 'Text',
          //             validator: (v) => v,
          //           ),
          //     ),
          //     WidgetPreview(
          //       text: 'TimePicker',
          //       widget: SizedBox(
          //         width: 200,
          //         height: 150,
          //         child: _i.createTimePicker().render(
          //               startTime: TimeOfDay.now(),
          //               onChanged: (v) {},
          //             ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class WidgetPreview extends StatelessWidget {
  final String text;
  final Widget widget;
  const WidgetPreview({super.key, required this.text, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CodeText(text),
        Gap(styles.insets.xs),
        widget,
        Divider(
          color: colors.greyMedium,
        ),
      ],
    );
  }
}

class CodeText extends StatelessWidget {
  final String text;
  const CodeText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(styles.insets.xs),
      decoration: BoxDecoration(
        color: colors.bodyDark,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          color: colors.white,
        ),
      ),
    );
  }
}
