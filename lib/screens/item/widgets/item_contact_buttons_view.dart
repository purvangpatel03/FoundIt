import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/screens/main_chat/chat/chat_screen.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/text_widget.dart';

import '../../../firebase/firebase_helper.dart';
import '../../../models/message_req_data.dart';

class ItemButtonView extends StatelessWidget {
  final String itemId;
  final String uid;
  const ItemButtonView({super.key, required this.uid, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final String currentId = FirebaseAuth.instance.currentUser!.uid;
    final String peerId = uid;
    final String? groupId;
    if (currentId.hashCode <= peerId.hashCode) {
      groupId = '$currentId-$peerId';
    } else {
      groupId = '$peerId-$currentId';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Visibility(
          visible: peerId != currentId,
          child: FilledButton(
            onPressed: () async{
              if(currentId != peerId){
                await FirebaseHelper().createMessageReq(
                  MessageReqData(
                    itemId: itemId,
                    idFrom: currentId,
                    idTo: peerId,
                    groupId: groupId!,
                  ),
                );
                if(context.mounted){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        uid: uid,
                        itemId: itemId,
                      ),
                    ),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(
              fixedSize: const Size.fromHeight(56),
              backgroundColor: ThemeColor.tertiary,
            ),
            child: TextWidget(
              maxLines: 2,
              text: 'Send Message',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ThemeColor.lightWhite,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
        Visibility(
          visible:  peerId == currentId,
          child: TextWidget(
            text: 'You added this item.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ThemeColor.tertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
