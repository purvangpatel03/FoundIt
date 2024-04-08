import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:foundit/widgets/textformfield_widget.dart';

class TitleAndDescView extends StatelessWidget {
  final Function(String) title;
  final Function(String) description;
  TitleAndDescView({super.key, required this.description, required this.title});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        TextWidget(
          text: 'Title',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ThemeColor.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormFieldWidget(
          keyboardType: TextInputType.multiline,
          controller: titleController,
          onChanged: (value){
            title(value);
          },
          hintText: 'Enter title of product',
        ),
        const SizedBox(
          height: 16,
        ),
        TextWidget(
          text: 'Description',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ThemeColor.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormFieldWidget(
          maxLine: null,
          onChanged: (value){
            description(value);
          },
          controller: descController,
          hintText: 'Enter description of product',
        ),
      ],
    );
  }
}
