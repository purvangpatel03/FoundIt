import 'package:flutter/material.dart';
import 'package:foundit/firebase/firebase_helper.dart';
import 'package:foundit/models/message_req_data.dart';

class ChatProvider with ChangeNotifier{

  List<MessageReqData> requests = [];

  getMessageRequests(String uid) async{
    requests.clear();
    requests = await FirebaseHelper().getMessageRequests(uid);
    notifyListeners();
  }

}