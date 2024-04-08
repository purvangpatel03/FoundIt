import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/firebase/firebase_helper.dart';
import 'package:foundit/models/message_data.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:foundit/widgets/textformfield_widget.dart';

class ChatBody extends StatefulWidget {
  final String uid;
  final String itemId;

  const ChatBody({super.key, required this.uid, required this.itemId});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final String currentId = FirebaseAuth.instance.currentUser!.uid;
    final String peerId = widget.uid;
    final String? groupId;
    if (currentId.hashCode <= peerId.hashCode) {
      groupId = '$currentId-$peerId';
    } else {
      groupId = '$peerId-$currentId';
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          reverse: true,
          child: StreamBuilder(
              stream: FirebaseHelper().getMessageStream(groupId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ...List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          return buildMessageList(
                            context,
                            snapshot.data!.docs[index],
                            currentId,
                            width,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 72,
                      ),
                    ],
                  );
                }
                return TextWidget(
                    text: 'No messages yet',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ThemeColor.lightGrey,
                          fontWeight: FontWeight.w600,
                        ));
              }),
        ),
        Positioned(
          width: width,
          bottom: 0,
          child: PhysicalModel(
            color: ThemeColor.lightWhite,
            elevation: 12,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      maxLine: null,
                      controller: messageController,
                      hintText: 'Start typing here...',
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        await FirebaseHelper().sendMessage(
                          groupId!,
                          MessageData(
                            itemId: widget.itemId,
                            idFrom: currentId,
                            idTo: peerId,
                            timestamp: DateTime.now()
                                .millisecondsSinceEpoch,
                            content: messageController.text,
                          ),
                        );
                        messageController.clear();
                      } on FirebaseException catch (e) {
                        print(e);
                      }
                    },
                    icon: Icon(
                      color: ThemeColor.tertiary,
                      Icons.send,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMessageList(BuildContext context, DocumentSnapshot? document,
      String currentId, double width) {
    if (document == null) {
      return const SizedBox.shrink();
    }
    final messageData = MessageData.fromDocument(document);
    if (messageData.idFrom == currentId) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.fromLTRB(width / 3.6, 0, 16, 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeColor.tertiary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: TextWidget(
            maxLines: 50,
            text: messageData.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeColor.lightWhite,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 0, width / 3.6, 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeColor.lightGrey,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: TextWidget(
            maxLines: 50,
            text: messageData.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeColor.text,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }
  }
}
