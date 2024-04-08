import 'package:flutter/material.dart';
import 'package:foundit/widgets/text_widget.dart';

import '../theme/colors.dart';

class MySnackBar{

  SnackBar mySnackBar({
    double? elevation,
    Color? backgroundColor,
    int? duration,
    required String text,
    Color? textColor,
    required BuildContext context,
  }) {
    return SnackBar(
      duration: Duration(seconds: duration ?? 1),
      showCloseIcon: true,
      elevation: elevation ?? 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: backgroundColor ?? ThemeColor.text,
      padding: const EdgeInsets.all(12),
      content: TextWidget(
        text: text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: textColor ?? ThemeColor.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

}