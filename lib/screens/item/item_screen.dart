import 'package:flutter/material.dart';
import 'package:foundit/models/item_data.dart';
import 'package:foundit/screens/item/widgets/item_add_info_view.dart';
import 'package:foundit/screens/item/widgets/item_app_bar.dart';
import 'package:foundit/screens/item/widgets/item_contact_buttons_view.dart';
import 'package:foundit/screens/item/widgets/item_image_view.dart';
import 'package:foundit/screens/item/widgets/item_info_view.dart';

class ItemScreen extends StatelessWidget {
  final ItemData itemData;
  const ItemScreen({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ItemAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ItemImageView(
                photo1: itemData.photo1,
                photo2: itemData.photo2,
              ),
              ItemInfoView(
                itemData: itemData,
              ),
              ItemAddInfoView(
                description: itemData.description,
              ),
              ItemButtonView(
                itemId: itemData.docId!,
                uid: itemData.uid,
              ),
              const SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}
