import 'package:flutter/material.dart';
import 'package:foundit/screens/main_chat/chat/widgets/chat_body_view.dart';
import 'package:foundit/screens/main_chat/chat/widgets/chat_screen_app_bar.dart';

class ChatScreen extends StatelessWidget {
  final String uid;
  final String itemId;
  const ChatScreen({super.key, required this.uid, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatScreenAppBar(),
      body: ChatBody(
        uid: uid,
        itemId: itemId,
      ),
    );
  }
}
