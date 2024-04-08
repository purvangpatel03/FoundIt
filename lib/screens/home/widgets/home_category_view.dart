import 'package:flutter/material.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

class HomeCategoryView extends StatefulWidget {
  final Function(String) selectedCategory;
  const HomeCategoryView({super.key, required this.selectedCategory});

  @override
  State<HomeCategoryView> createState() => _HomeCategoryViewState();
}

class _HomeCategoryViewState extends State<HomeCategoryView> {

  List<String> items = ['All', 'Gadgets', 'Keys','Documents', 'Wallet', 'Jewelry', 'Accessories', 'Books', 'Tickets', 'Clothing', 'Other'];
  String selectedCat = 'All';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: (){
                  widget.selectedCategory(items[index]);
                  setState(() {
                    selectedCat = items[index];
                  });
                },
                child: TextWidget(
                  text: items[index],
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selectedCat == items[index] ? ThemeColor.secondary : ThemeColor.tertiary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
