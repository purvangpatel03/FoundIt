import 'package:flutter/material.dart';
import 'package:foundit/models/item_data.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

class ItemInfoView extends StatelessWidget {
  final ItemData itemData;

  const ItemInfoView({
    super.key,
    required this.itemData
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Chip(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              label: TextWidget(
                maxLines: 2,
                text: itemData.itemType,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ThemeColor.lightWhite,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        TextWidget(
          text: itemData.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ThemeColor.text,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Icon(
              size: 20,
              Icons.watch_later_outlined,
            ),
            const SizedBox(
              width: 2,
            ),
            TextWidget(
              maxLines: 2,
              text: '2 days ago.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ThemeColor.grey,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Icon(
              size: 20,
              Icons.location_on,
            ),
            const SizedBox(
              width: 2,
            ),
            TextWidget(
              maxLines: 2,
              text: itemData.location,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ThemeColor.grey,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
