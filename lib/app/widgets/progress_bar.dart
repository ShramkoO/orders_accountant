import 'package:orders_accountant/core/constants/common_libs.dart';

class ProgressBar extends StatelessWidget {
  final int maxPoints;
  final double livePoints;
  final double? length;
  final double width;
  final Color? color;
  final Color? secondColor;

  const ProgressBar(
      {super.key,
      required this.maxPoints,
      required this.livePoints,
      this.length,
      this.width = 3,
      this.color,
      this.secondColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: length,
      child: Stack(
        children: [
          Row(
            children: [
              Flexible(
                  flex: ((maxPoints - livePoints) * 1000).round(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondColor ?? const Color(0xFFb3b8be),
                        borderRadius: BorderRadius.circular(width / 2)),
                    height: width,
                  ))
            ],
          ),
          Row(
            children: [
              Flexible(
                  flex: (livePoints * 1000).round(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: color ?? colors.steelGrey,
                        borderRadius: BorderRadius.circular(width / 2)),
                    height: width,
                  )),
              Flexible(
                  flex: ((maxPoints - livePoints) * 1000).round(),
                  child: Container())
            ],
          ),
        ],
      ),
    );
  }
}
