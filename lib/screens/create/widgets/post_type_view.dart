import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

class PostTypeView extends StatefulWidget {
  final Function(String) postType;
  const PostTypeView({super.key, required this.postType});

  @override
  State<PostTypeView> createState() => _PostTypeViewState();
}

class _PostTypeViewState extends State<PostTypeView> {

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16,),
        TextWidget(
          text: 'Post Type',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ThemeColor.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: (){
                widget.postType('lost');
                setState(() {
                  selectedType = 'lost';
                });
              },
              child: Chip(
                backgroundColor: selectedType == 'lost' ? ThemeColor.tertiary : ThemeColor.primary,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                label: TextWidget(
                  maxLines: 2,
                  text: 'Lost',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    color: ThemeColor.lightWhite,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16,),
            GestureDetector(
              onTap: (){
                widget.postType('found');
                setState(() {
                  selectedType = 'found';
                });
              },
              child: Chip(
                backgroundColor: selectedType == 'found' ? ThemeColor.secondary : ThemeColor.secondary.withOpacity(0.6),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                label: TextWidget(
                  maxLines: 2,
                  text: 'Found',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    color: ThemeColor.lightWhite,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
