import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:flutter/foundation.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {Key? key, this.size = 22, this.color})
      : super(key: key);
  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    String i = describeEnum(icon).toLowerCase();
    String path = 'assets/icons/$i.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(path,
            width: size,
            height: size,
            color: color ?? colors.white,
            filterQuality: FilterQuality.high),
      ),
    );
  }
}

// add Icons here
// name should be the filename
enum AppIcons {
  heart,
}
