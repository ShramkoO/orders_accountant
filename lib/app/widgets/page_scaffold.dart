import 'package:orders_accountant/core/constants/common_libs.dart';

class PageScaffold extends StatefulWidget {
  final Widget body;
  final bool hideAppBar;
  final bool showSettings;
  final String? title;
  const PageScaffold({
    super.key,
    required this.body,
    this.hideAppBar = false,
    this.title,
    this.showSettings = true,
  });

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: widget.hideAppBar
          ? null
          : widgets.createNavigationBar().render(
                title: widget.title ?? '',
              ),
      body: SafeArea(child: widget.body),
    );
  }
}
