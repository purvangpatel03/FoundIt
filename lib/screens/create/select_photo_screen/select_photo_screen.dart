import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/models/item_data.dart';
import 'package:foundit/providers/item_provider.dart';
import 'package:foundit/screens/create/select_photo_screen/widgets/select_photo_app_bar.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/dialog_box_widget.dart';
import 'package:foundit/widgets/filled_button_widget.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SelectPhotoScreen extends StatefulWidget {
  final String category;
  final String title;
  final String description;
  final String location;
  final String itemType;

  const SelectPhotoScreen({
    super.key,
    required this.category,
    required this.location,
    required this.description,
    required this.title,
    required this.itemType,
  });

  @override
  State<SelectPhotoScreen> createState() => _SelectPhotoScreenState();
}

class _SelectPhotoScreenState extends State<SelectPhotoScreen> {
  ValueNotifier<File?> photo1 = ValueNotifier(null);
  ValueNotifier<File?> photo2 = ValueNotifier(null);
  ValueNotifier<bool> allPhotoSelected = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Future selectPhoto() async {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        return selected;
      }
    }

    return Scaffold(
      appBar: const SelectPhotoAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextWidget(
                maxLines: 2,
                text: 'Add 2 Pictures. Use real pictures and not catalogs.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ThemeColor.text,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              ValueListenableBuilder<File?>(
                  valueListenable: photo1,
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () async {
                        photo1.value = await selectPhoto();
                      },
                      child: value == null
                          ? Container(
                              width: width,
                              height: width - 80,
                              margin: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: ThemeColor.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                size: 42,
                                color: ThemeColor.lightGrey,
                                Icons.camera_alt,
                              ),
                            )
                          : Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: width,
                                  margin: const EdgeInsets.all(24),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image(
                                    width: width - 48,
                                    fit: BoxFit.cover,
                                    image: FileImage(value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 20.0,
                                    top: 20,
                                  ),
                                  child: IconButton(
                                    color: Colors.red.withOpacity(0.7),
                                    onPressed: () {
                                      photo1.value = null;
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ),
                              ],
                            ),
                    );
                  }),
              ValueListenableBuilder<File?>(
                valueListenable: photo2,
                builder: (context, value, child) {
                  return GestureDetector(
                    onTap: () async {
                      photo2.value = await selectPhoto();
                    },
                    child: value == null
                        ? Container(
                            width: width,
                            height: width - 80,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: ThemeColor.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              size: 42,
                              color: ThemeColor.lightGrey,
                              Icons.camera_alt,
                            ),
                          )
                        : Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: width,
                                margin: const EdgeInsets.all(24),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: ThemeColor.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image(
                                  width: width - 48,
                                  fit: BoxFit.cover,
                                  image: FileImage(value),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20.0, top: 20),
                                child: IconButton(
                                  color: Colors.red.withOpacity(0.7),
                                  onPressed: () {
                                    photo2.value = null;
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              )
                            ],
                          ),
                  );
                },
              ),
              const SizedBox(height: 12,),
              ValueListenableBuilder<bool>(
                valueListenable: allPhotoSelected,
                builder: (context, value, child) {
                  return Visibility(
                    visible: allPhotoSelected.value,
                    child: TextWidget(
                      text: 'Please select all photos.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.redAccent.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              FilledButtonWidget(
                text: 'Done',
                onPressed: () async {
                  if (photo1.value != null && photo2.value != null) {
                    try{
                      await Provider.of<ItemProvider>(context, listen: false)
                          .createItem(
                        ItemData(
                          title: widget.title,
                          description: widget.description,
                          location: widget.location,
                          category: widget.category,
                          itemType: widget.itemType,
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          photo1: photo1.value!.path,
                          photo2: photo2.value!.path,
                        ),
                        photo1.value!,
                        photo2.value!,
                      );
                      if(context.mounted){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogBoxWidget(
                              text: 'Item Added.',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context, '/',(Route<dynamic> route) => false);
                              },
                            );
                          },
                        );
                      }
                    }on FirebaseException catch(e){
                      print(e.message);
                    }
                  }
                  else{
                    allPhotoSelected.value = true;
                  }
                },
                backgroundColor: ThemeColor.secondary,
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ThemeColor.lightWhite,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
