import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

class ItemAddInfoView extends StatelessWidget {
  final String description;
  const ItemAddInfoView({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget(
          maxLines: 2,
          text: 'Item Description',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ThemeColor.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: ThemeColor.secondary,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: TextWidget(
            maxLines: 2,
            text: description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ThemeColor.text,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}
