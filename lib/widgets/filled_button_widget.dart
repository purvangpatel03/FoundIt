import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

class FilledButtonWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Size? fixedSize;
  final OutlinedBorder? shape;

  const FilledButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.fixedSize,
    this.textStyle,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor ?? ThemeColor.primary,
        fixedSize: fixedSize ?? const Size.fromHeight(48),
        shape: shape ?? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: TextWidget(
        text: text,
        style: textStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeColor.lightWhite,
                  fontWeight: FontWeight.w500,
                ),
      ),
    );
  }
}
