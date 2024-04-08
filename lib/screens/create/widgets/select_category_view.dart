import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

class SelectCategoryView extends StatefulWidget {
  final Function(String) category;
  const SelectCategoryView({super.key, required this.category});

  @override
  State<SelectCategoryView> createState() => _SelectCategoryViewState();
}

class _SelectCategoryViewState extends State<SelectCategoryView> {

  List<String> categories = [
    'Gadgets',
    'Keys',
    'Documents',
    'Wallet',
    'Jewelry',
    'Accessories',
    'Books',
    'Tickets',
    'Clothing',
    'Other',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Category',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ThemeColor.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          height: 50,
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: ThemeColor.mediumGrey,
                      width: 2,
                    )
                ),
                contentPadding: const EdgeInsets.only(right: 8),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: ThemeColor.mediumGrey,
                        width: 2
                    )
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      color: ThemeColor.mediumGrey,
                      width: 2
                  ),
                ),
              ),
              value: selectedValue,
              borderRadius: BorderRadius.circular(16),
              dropdownColor: ThemeColor.lightWhite,
              elevation: 4,
              iconEnabledColor: ThemeColor.primary,
              menuMaxHeight: 300,
              isExpanded: true,
              hint: TextWidget(
                text: 'Select a category',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ThemeColor.mediumGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              items: List.generate(categories.length, (index) {
                return DropdownMenuItem<String>(
                  value: categories[index],
                  child: TextWidget(
                    text: categories[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ThemeColor.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }),
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    widget.category(value);
                    setState(() {
                      selectedValue = value;
                    });
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
