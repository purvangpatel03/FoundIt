import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foundit/theme/colors.dart';

class ItemImageView extends StatefulWidget {
  final String photo1;
  final String photo2;

  const ItemImageView({super.key, required this.photo1, required this.photo2});

  @override
  State<ItemImageView> createState() => _ItemImageViewState();
}

class _ItemImageViewState extends State<ItemImageView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height / 2,
          child: PageView.builder(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                width: double.maxFinite,
                margin: const EdgeInsets.all(20),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Hero(
                  tag: index == 0 ? widget.photo1 : widget.photo2,
                  child: Image.network(
                    fit: BoxFit.contain,
                    index == 0 ? widget.photo1 : widget.photo2,
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) => Container(
              height: 10,
              width: 10,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIndex == index
                    ? ThemeColor.tertiary
                    : ThemeColor.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
