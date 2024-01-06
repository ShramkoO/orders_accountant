import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:cuckoo_starter_kit/app/features/onboarding/widgets/onboarding_content.dart';

class OnboardingPageModel {
  final String? title;
  final Widget? titleWidget;
  final String? body;
  final Widget? bodyWidget;
  final Widget? image;
  final Widget? footer;

  OnboardingPageModel({
    this.title,
    this.titleWidget,
    this.body,
    this.bodyWidget,
    this.image,
    required this.footer,
  })  : assert(title != null || titleWidget != null,
            'Provide either title or titleWidget'),
        assert((title == null) != (titleWidget == null),
            'Don\'t provide both title and titleWidget'),
        assert(body != null || bodyWidget != null,
            'Provide either body or bodyWidget'),
        assert((body == null) != (bodyWidget == null),
            'Don\'t provide both body and bodyWidget');
}

class OnboardingPage extends StatefulWidget {
  final OnboardingPageModel page;
  final ScrollController scrollController;
  const OnboardingPage(
      {super.key, required this.page, required this.scrollController});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final OnboardingPageModel page = widget.page;

    final orientation = MediaQuery.orientationOf(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: Flex(
        direction: orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...[
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(styles.insets.sm),
                  child: page.image,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: OnboardingContent(page: page),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
