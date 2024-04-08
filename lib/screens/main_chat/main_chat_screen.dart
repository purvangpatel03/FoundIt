import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/providers/chat_provider.dart';
import 'package:foundit/providers/item_provider.dart';
import 'package:foundit/providers/user_provider.dart';
import 'package:foundit/screens/main_chat/chat/chat_screen.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../models/item_data.dart';
import '../../models/user_data.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({super.key});

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  late BuildContext myContext;

  List<UserData?> userdata = [];
  List<ItemData?> itemData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final chat = Provider.of<ChatProvider>(myContext, listen: false);
      final item = Provider.of<ItemProvider>(myContext, listen: false);
      final user = Provider.of<UserProvider>(myContext, listen: false);
      await chat.getMessageRequests(FirebaseAuth.instance.currentUser!.uid);
      item.getReqItem(chat.requests);
      user.getReqUser(chat.requests);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<ChatProvider>(builder: (context, value, child) {
      print(value.requests.length);
      myContext = context;
      if (value.requests.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextWidget(
            text: 'No pending requests.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeColor.tertiary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        );
      } else {
        return ListView.builder(
          itemCount: value.requests.length,
          itemBuilder: (context, index) {
            String id = value.requests[index].idFrom;
            String peerId = id == FirebaseAuth.instance.currentUser!.uid
                ? value.requests[index].idTo
                : id;
            Provider.of<UserProvider>(myContext, listen: false).getUser(peerId);
            Provider.of<ItemProvider>(context, listen: false)
                .getItemById(value.requests[index].itemId);
            return Padding(
              padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        uid: peerId,
                        itemId: value.requests[index].itemId,
                      ),
                    ),
                  );
                },
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(20),
                  color: ThemeColor.lightGrey,
                  elevation: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    width: width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child:
                        Consumer<UserProvider>(builder: (context, user, child) {
                      return Consumer<ItemProvider>(
                          builder: (context, item, child) {
                            if(user.reqUserList.length == value.requests.length  && item.msgReqItems.length == value.requests.length){
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: user.reqUserList[index]?.name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                            color: ThemeColor.tertiary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextWidget(
                                          text: 'About ${item.msgReqItems[index].title}...',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            color: ThemeColor.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Visibility(
                                  //   visible: item.selectedItem != null,
                                  //   child: FloatingActionButton(
                                  //     elevation: 4,
                                  //     mini: true,
                                  //     child: const Icon(Icons.info_outline_rounded),
                                  //     onPressed: () {
                                  //       if(item.selectedItem != null){
                                  //         Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 ItemScreen(itemData: item.selectedItem!),
                                  //           ),
                                  //         );
                                  //       }
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              );
                            }
                            else{
                              return Center(
                                child: CircularProgressIndicator(
                                  color: ThemeColor.primary,
                                ),
                              );
                            }
                      });
                    }),
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }
}
