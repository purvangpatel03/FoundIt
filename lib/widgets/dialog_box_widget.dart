import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/filled_button_widget.dart';
import 'package:foundit/widgets/text_widget.dart';

class DialogBoxWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final void Function() onPressed;

  const DialogBoxWidget({super.key, required this.text, this.textStyle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidget(
        text: text,
        textAlign: TextAlign.center,
        style: textStyle ??
            Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ThemeColor.text,
                  fontWeight: FontWeight.w700,
                ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButtonWidget(
          backgroundColor: ThemeColor.secondary,
          text: 'Done',
          onPressed: onPressed,
        ),
      ],
    );
  }
}
