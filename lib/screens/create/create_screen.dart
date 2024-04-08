import 'package:flutter/material.dart';
import 'package:foundit/screens/create/select_photo_screen/select_photo_screen.dart';
import 'package:foundit/screens/create/widgets/continue_button_view.dart';
import 'package:foundit/screens/create/widgets/create_location_view.dart';
import 'package:foundit/screens/create/widgets/post_type_view.dart';
import 'package:foundit/screens/create/widgets/select_category_view.dart';
import 'package:foundit/screens/create/widgets/title_and_desc_view.dart';
import 'package:foundit/widgets/text_widget.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  ValueNotifier<bool> isVisible = ValueNotifier(false);

  String? title;
  String? description;
  String? category;
  String? location;
  String? itemType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectCategoryView(
              category: (value) {
                category = value;
              },
            ),
            PostTypeView(
              postType: (type) {
                itemType = type;
              },
            ),
            TitleAndDescView(
              title: (newTitle) {
                title = newTitle;
              },
              description: (newDescription) {
                description = newDescription;
              },
            ),
            CreateLocationView(
              location: (value) {
                location = value;
              },
            ),
            ContinueButtonView(
              onPressed: () {
                  if (title != null &&
                      description != null &&
                      category != null &&
                      location != null &&
                      itemType != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectPhotoScreen(
                          title: title!,
                          description: description!,
                          category: category!,
                          location: location!,
                          itemType: itemType!,
                        ),
                      ),
                    );
                  } else {
                    isVisible.value = true;
                  }
              },
            ),
            const SizedBox(height: 8,),
            ValueListenableBuilder<bool>(
              valueListenable: isVisible,
              builder: (context, value, child) {
                return Visibility(
                  visible: isVisible.value,
                  child: TextWidget(
                    text: 'Please fill all details.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.redAccent.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
