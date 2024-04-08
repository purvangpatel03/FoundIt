import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foundit/screens/home/widgets/home_category_view.dart';
import 'package:foundit/screens/home/widgets/home_item_view.dart';

class HomeScreen extends StatefulWidget {
  final bool myItems;
  const HomeScreen({super.key, required this.myItems});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCat = 'All';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Visibility(
            visible: !widget.myItems,
            child: HomeCategoryView(
              selectedCategory: (value){
                setState(() {
                  selectedCat = value;
                });
              },
            ),
          ),
          Expanded(
            child: HomeItemView(
              myItems: widget.myItems,
              selectedCat: selectedCat,
            ),
          ),
        ],
      ),
    );
  }
}
