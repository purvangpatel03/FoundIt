import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

class SelectPhotoAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SelectPhotoAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        text: 'Select Photo',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: ThemeColor.text,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
