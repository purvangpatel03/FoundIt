
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/firebase/firebase_helper.dart';
import 'package:foundit/models/user_data.dart';

import '../models/message_req_data.dart';

class UserProvider with ChangeNotifier{

  UserData? currentUser;

  List<UserData?> reqUserList = [];

  getUser(String uid)async{
    currentUser = await FirebaseHelper().getUser(uid);
    notifyListeners();
  }

  getReqUser(List<MessageReqData> requests)async{
    reqUserList.clear();
    for (var req in requests) {
      String id = req.idFrom;
      String peerId =
      id == FirebaseAuth.instance.currentUser!.uid ? req.idTo : id;
      reqUserList.add(await FirebaseHelper().getUser(peerId));
    }
    notifyListeners();
  }

}