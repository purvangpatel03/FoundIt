import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/firebase/firebase_helper.dart';
import 'package:foundit/models/item_data.dart';

import '../models/message_req_data.dart';

class ItemProvider with ChangeNotifier {

  List<ItemData> itemData = [];

  List<ItemData> userItems = [];

  List<ItemData> msgReqItems = [];

  ItemData? selectedItem;

  getItems() async {
    //itemData = await FirebaseHelper().getAllItems();
    return await FirebaseHelper().getAllItems();
    //notifyListeners();
  }

  getItemById(String itemId) async{
    selectedItem = await FirebaseHelper().getItemById(itemId);
    notifyListeners();
  }

  getReqItem(List<MessageReqData> requests) async{
    msgReqItems.clear();
    for (var req in requests) {
      msgReqItems.add(await FirebaseHelper().getItemById(req.itemId));
    }
    notifyListeners();
  }

  Future<List<ItemData>> getItemsByCat(String cat) async{
    if(cat == 'All'){
      //itemData.clear();
      return await getItems();
    }
    else{
      //itemData.clear();
      //itemData = await FirebaseHelper().getItemsByCat(cat);
      return await FirebaseHelper().getItemsByCat(cat);
    }
    // notifyListeners();
  }

  Future<List<ItemData>> getUserItems() async {
    return await FirebaseHelper().getUserItems(FirebaseAuth.instance.currentUser!.uid);
  }

  createItem(ItemData itemData, File photo1, File photo2) async{
    await FirebaseHelper().createItem(itemData, photo1, photo2);
    notifyListeners();
  }

  deleteItem(String docId) async{
    FirebaseHelper().deleteItemById(docId);
  }
}
