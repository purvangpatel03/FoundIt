import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:foundit/providers/item_provider.dart';
import 'package:foundit/screens/item/item_screen.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/filled_button_widget.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class HomeItemView extends StatefulWidget {
  final bool myItems;
  final String selectedCat;

  const HomeItemView(
      {super.key, required this.selectedCat, required this.myItems});

  @override
  State<HomeItemView> createState() => _HomeItemViewState();
}

class _HomeItemViewState extends State<HomeItemView> {
  // late BuildContext myContext;
  //
  // @override
  // void didUpdateWidget(covariant HomeItemView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Provider.of<ItemProvider>(myContext, listen: false)
  //         .getItemsByCat(widget.selectedCat);
  //   });
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Provider.of<ItemProvider>(myContext, listen: false)
  //         .getItemsByCat(widget.selectedCat);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: widget.myItems
          ? Provider.of<ItemProvider>(context, listen: false).getUserItems()
          : Provider.of<ItemProvider>(context, listen: false)
              .getItemsByCat(widget.selectedCat),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasData){
            if (snapshot.data!.isEmpty) {
              return TextWidget(
                text: "No items found.🥺",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ThemeColor.tertiary,
                  fontWeight: FontWeight.w700,
                ),
              );
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final containerWidth = (width / 2) - 18;
                  final containerHeight = containerWidth / 0.55;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemScreen(
                            itemData: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ThemeColor.lightGrey,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: (containerHeight) / 2,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ThemeColor.primary,
                            ),
                            child: Hero(
                              tag: snapshot.data![index].photo1,
                              child: Image.network(
                                fit: BoxFit.cover,
                                snapshot.data![index].photo1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: snapshot.data![index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: ThemeColor.text,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextWidget(
                                  text: snapshot.data![index].description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: ThemeColor.text,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      size: 16,
                                      Icons.location_on,
                                    ),
                                    Expanded(
                                      child: TextWidget(
                                        text: snapshot.data![index].location,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                          color: ThemeColor.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Chip(
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                  label: TextWidget(
                                    text: snapshot.data![index].itemType,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                      color: ThemeColor.lightWhite,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextWidget(
                                  text: '2 days ago..',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    color: ThemeColor.mediumGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 28,
                            child: FilledButtonWidget(
                              backgroundColor: widget.myItems
                                  ? Colors.redAccent.withOpacity(0.7)
                                  : ThemeColor.primary,
                              fixedSize: const Size.fromHeight(28),
                              text: widget.myItems ? 'Delete' : 'Share',
                              onPressed: () async {
                                if (widget.myItems) {
                                  await Provider.of<ItemProvider>(context,
                                      listen: false)
                                      .deleteItem(
                                      snapshot.data![index].docId ?? '');
                                  setState(() {

                                  });
                                } else {
                                  await FlutterShare.share(
                                    title: 'Check out this item.',
                                    text: snapshot.data![index].title,
                                  );
                                }
                              },
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                color: ThemeColor.lightWhite,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          else{
            TextWidget(
              text: "No data found. Please check you connection",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: ThemeColor.tertiary,
                fontWeight: FontWeight.w700,
              ),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(
            color: ThemeColor.primary,
          ),
        );
      },
    );
  }
}
