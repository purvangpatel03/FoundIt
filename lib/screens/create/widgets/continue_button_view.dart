import 'package:flutter/material.dart';
import 'package:foundit/models/item_data.dart';
import 'package:foundit/screens/create/select_photo_screen/select_photo_screen.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/filled_button_widget.dart';
import 'package:foundit/widgets/text_widget.dart';

class ContinueButtonView extends StatelessWidget {
  final void Function() onPressed;
  const ContinueButtonView({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return FilledButtonWidget(
      backgroundColor: ThemeColor.secondary,
      text: 'Continue',
      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ThemeColor.lightWhite,
            fontWeight: FontWeight.w500,
          ),
      onPressed: onPressed,
    );
  }
}
