import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:foundit/widgets/textformfield_widget.dart';

class CreateLocationView extends StatelessWidget {
  final Function(String) location;

  CreateLocationView({super.key, required this.location});

  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    locationController.addListener(() {
      location(locationController.text);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        TextWidget(
          text: 'Location',
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
            color: ThemeColor.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormFieldWidget(
          onChanged: (value){
            location(value);
          },
          controller: locationController,
          hintText: 'Select Location',
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}
