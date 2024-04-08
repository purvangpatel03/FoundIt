import 'package:flutter/material.dart';
import 'package:foundit/screens/home/home_screen.dart';

import '../../../theme/colors.dart';
import '../../../widgets/text_widget.dart';

class MyItemsView extends StatelessWidget {
  const MyItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'Your items.',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: ThemeColor.text,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: const HomeScreen(myItems: true),
    );
  }
}
