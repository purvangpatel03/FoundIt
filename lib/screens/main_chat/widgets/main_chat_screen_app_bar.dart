import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

class MainChatAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MainChatAppBar({super.key});


  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        text: 'Chat Requests',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: ThemeColor.text,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

}
