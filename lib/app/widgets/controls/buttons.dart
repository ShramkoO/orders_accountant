// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:gap/gap.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.onPressed,
    this.semanticLabel,
    this.text,
    this.child,
    this.bgColor,
    this.border,
    this.padding,
    this.expand = false,
    this.circular = false,
    this.textStyle,
    this.icon,
    this.prefixIcon,
  })  : _builder = null,
        assert(
          (semanticLabel != null) || (text != null),
          'Must include either text or semanticLabel',
        ),
        assert(
          (child != null) || (text != null) || (icon != null),
          'Must include either text, icon or child',
        );

  final VoidCallback onPressed;
  final String? semanticLabel;
  final String? text;
  late final Widget? child;
  final Color? bgColor;
  final BorderSide? border;
  final EdgeInsets? padding;
  final bool expand;
  final bool circular;
  final TextStyle? textStyle;
  final Widget? icon;
  final IconData? prefixIcon;

  late final WidgetBuilder? _builder;

  AppButton.text({
    super.key,
    required this.onPressed,
    this.semanticLabel,
    required this.text,
    this.textStyle,
  })  : child = null,
        bgColor = Colors.transparent,
        expand = false,
        padding = EdgeInsets.zero,
        border = BorderSide.none,
        circular = false,
        prefixIcon = null,
        icon = null {
    _builder = (context) {
      return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text!,
          style: textStyle,
        ),
      );
    };
  }

  AppButton.filled({
    super.key,
    required this.onPressed,
    this.semanticLabel,
    required this.text,
    this.bgColor,
    this.textStyle,
    this.prefixIcon,
  })  : child = null,
        expand = false,
        padding = EdgeInsets.zero,
        border = BorderSide.none,
        circular = false,
        icon = null {
    _builder = (context) {
      Widget child = Text(text!, style: textStyle);
      if (prefixIcon != null) {
        child = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(prefixIcon,
                color: textStyle?.color, size: textStyle?.fontSize ?? 16),
            // prefixIcon!,
            Gap(styles.insets.xxs),
            child,
          ],
        );
      }
      return FilledButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
            backgroundColor: ButtonStyleButton.allOrNull<Color>(bgColor)),
        child: child,
      );
    };
  }

  AppButton.icon({
    super.key,
    required this.onPressed,
    required this.semanticLabel,
    this.bgColor,
    required this.icon,
  })  : child = null,
        expand = false,
        padding = EdgeInsets.zero,
        border = BorderSide.none,
        circular = true,
        text = null,
        prefixIcon = null,
        textStyle = null {
    _builder = (context) {
      return CircleAvatar(
        backgroundColor: bgColor,
        child: IconButton(
          onPressed: onPressed,
          icon: icon!,
        ),
      );
    };
  }

  AppButton.from({
    super.key,
    required this.onPressed,
    this.semanticLabel,
    this.child,
    this.padding,
    this.expand = false,
    this.text,
    this.bgColor,
    this.border,
    this.circular = false,
    this.textStyle,
  })  : icon = null,
        prefixIcon = null {
    Color defaultBackgroundColor = colors.accent1;
    Color defaultTextColor = colors.white;
    BorderSide side = border ?? BorderSide.none;

    OutlinedBorder shape = circular
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(
            side: side,
            borderRadius: BorderRadius.circular(styles.corners.md),
          );

    ButtonStyle style = ButtonStyle(
      minimumSize: ButtonStyleButton.allOrNull<Size>(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor:
          ButtonStyleButton.allOrNull<Color>(bgColor ?? defaultBackgroundColor),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(
          padding ?? EdgeInsets.all(styles.insets.md)),
    );

    _builder = (context) {
      Widget content = child ??
          Text(
            text!.toUpperCase(),
            style: textStyle ?? textStyles.bodySmall.c(defaultTextColor),
          );
      if (expand) content = Center(child: content);
      return TextButton(
        onPressed: () {
          onPressed();
        },
        style: style,
        child: content,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    Widget content =
        _builder?.call(context) ?? child ?? const SizedBox.shrink();

    if (semanticLabel != null && semanticLabel!.isNotEmpty) return content;

    return Semantics(
      label: semanticLabel ?? text,
      button: true,
      container: true,
      child: ExcludeSemantics(child: content),
    );
  }
}
