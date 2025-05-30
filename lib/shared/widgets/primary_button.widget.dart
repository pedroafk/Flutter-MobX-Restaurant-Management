import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final String? appIcon;
  final double? width;
  final bool dense;
  final bool iconToRight;
  final bool isDisabled;
  final bool isLoading;
  final double? horizontalPadding;
  final Size? iconSize;
  final Color? color;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.dense = false,
    this.width,
    this.text,
    this.appIcon,
    this.isDisabled = false,
    this.iconToRight = false,
    this.isLoading = false,
    this.horizontalPadding,
    this.iconSize,
    this.color,
    Color? backgroundColor,
  })  : assert(text != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: _getOnPressed(),
      style: _getButtonStyle(context),
      child: _getButtonContent(context),
    );
  }

  Function()? _getOnPressed() {
    if (isDisabled) {
      return null;
    }
    if (isLoading) {
      return () {};
    }
    return onPressed;
  }

  Widget? _getButtonContent(context) {
    if (isLoading) {
      return SizedBox(
        width: dense ? 12 : 16,
        height: dense ? 12 : 16,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    if (text != null) {
      var textWidget = Text(
        text!,
      );

      if (appIcon != null) {
        var svg = SvgPicture.asset(
          appIcon!,
          width: iconSize?.width ?? (dense ? 16 : 18),
          colorFilter: isDisabled ? const ColorFilter.mode(Colors.grey, BlendMode.srcIn) : null,
        );
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconToRight ? textWidget : svg,
            SizedBox(width: dense ? 6 : 10),
            iconToRight ? svg : textWidget,
          ],
        );
      }

      return textWidget;
    }
    return child;
  }

  ButtonStyle _getButtonStyle(context) {
    var btnStyle = ButtonStyle(
      fixedSize: width == null
          ? null
          : WidgetStateProperty.all<Size>(
              Size.fromWidth(width!),
            ),
      padding: WidgetStateProperty.all<EdgeInsets>(
        EdgeInsets.only(
          top: dense ? 10 : 20,
          bottom: dense ? 10 : 20,
          left: horizontalPadding ??
              ((appIcon != null && !iconToRight) ? (dense ? 12 : 22) : (dense ? 16 : 24)),
          right: horizontalPadding ??
              ((appIcon != null && iconToRight) ? (dense ? 12 : 22) : (dense ? 16 : 24)),
        ),
      ),
    );

    if (color != null) {
      btnStyle = btnStyle.copyWith(
        // foregroundColor: WidgetStateProperty.all<Color>(Colors.grey),
        backgroundColor: WidgetStateProperty.all<Color>(color!),
      );
    }

    if (isDisabled) {
      btnStyle = btnStyle.copyWith(
        // foregroundColor: WidgetStateProperty.all<Color>(Colors.grey),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.grey.shade100),
        side: WidgetStateProperty.all<BorderSide>(BorderSide(color: Colors.grey.shade100)),
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      );
    }

    return btnStyle.merge(FilledButtonTheme.of(context).style);
  }
}
