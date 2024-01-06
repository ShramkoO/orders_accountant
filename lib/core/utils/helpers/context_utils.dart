import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';

class ContextUtils {
  static Offset? getGlobalPos(BuildContext context,
      [Offset offset = Offset.zero]) {
    final box = context.findRenderObject() as RenderBox?;
    if (box?.hasSize == true) {
      return box?.localToGlobal(offset);
    }
    return null;
  }

  static Size? getSize(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box?.hasSize == true) {
      return box?.size;
    }
    return null;
  }
}
