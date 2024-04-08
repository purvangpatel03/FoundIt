import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foundit/models/item_data.dart';
import 'package:foundit/models/message_data.dart';
import 'package:foundit/models/message_req_data.dart';
import 'package:foundit/models/user_data.dart';

class FirebaseHelper {
  // User Queries

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userData');

  Future createUser(UserData userData) async {
    await userCollection.add(userData.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    QuerySnapshot querySnapshot =
        await userCollection.where('uid', isEqualTo: uid).get();
    UserData? user;
    for (var item in querySnapshot.docs) {
      final data = item.data() as Map<String, dynamic>;
      user = UserData(
        name: data['name'],
        email: data['email'],
        uid: data['uid'],
        photoURL: data['photoURL'],
        phoneNo: data['phoneNo'],
        docId: item.id,
      );
    }
    return user;
  }

  // Item Queries

  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('itemData');

  final storageRef = FirebaseStorage.instance.ref();

  Future createItem(ItemData itemData, File photo1, File photo2) async {
    await itemCollection.add(itemData.toMap());
    await storageRef.child(itemData.photo1).putFile(photo1);
    await storageRef.child(itemData.photo2).putFile(photo2);
  }

  Future deleteItemById(String docId) async{
    await itemCollection.doc(docId).delete();
  }

  Future<List<ItemData>> getAllItems() async {
    QuerySnapshot querySnapshot = await itemCollection.get();
    List<ItemData> itemData = [];
    for (var item in querySnapshot.docs) {
      final data = item.data() as Map<String, dynamic>;
      String photo1 = await storageRef.child(data['photo1']).getDownloadURL();
      String photo2 = await storageRef.child(data['photo2']).getDownloadURL();
      itemData.add(
        ItemData(
          title: data['title'],
          description: data['description'],
          location: data['location'],
          category: data['category'],
          itemType: data['itemType'],
          uid: data['uid'],
          photo1: photo1,
          photo2: photo2,
          docId: item.id,
        ),
      );
    }
    return itemData;
  }

  getItemById(String docId) async {
    var item = await itemCollection.doc(docId).get();
    final data = item.data() as Map<String, dynamic>;
    return ItemData(
      title: data['title'],
      description: data['description'],
      location: data['location'],
      category: data['category'],
      itemType: data['itemType'],
      uid: data['uid'],
      photo1: data['photo1'],
      photo2: data['photo2'],
    );
  }

  Future<List<ItemData>> getItemsByCat(String cat) async {
    QuerySnapshot querySnapshot =
        await itemCollection.where('category', isEqualTo: cat).get();
    List<ItemData> itemData = [];
    for (var item in querySnapshot.docs) {
      final data = item.data() as Map<String, dynamic>;
      String photo1 = await storageRef.child(data['photo1']).getDownloadURL();
      String photo2 = await storageRef.child(data['photo2']).getDownloadURL();
      itemData.add(
        ItemData(
          title: data['title'],
          description: data['description'],
          location: data['location'],
          category: data['category'],
          itemType: data['itemType'],
          uid: data['uid'],
          photo1: photo1,
          photo2: photo2,
          docId: item.id,
        ),
      );
    }
    return itemData;
  }

  Future<List<ItemData>> getUserItems(String uid) async {
    QuerySnapshot querySnapshot =
        await itemCollection.where('uid', isEqualTo: uid).get();
    List<ItemData> itemData = [];
    for (var item in querySnapshot.docs) {
      final data = item.data() as Map<String, dynamic>;
      String photo1 = await storageRef.child(data['photo1']).getDownloadURL();
      String photo2 = await storageRef.child(data['photo2']).getDownloadURL();
      itemData.add(
        ItemData(
          title: data['title'],
          description: data['description'],
          location: data['location'],
          category: data['category'],
          itemType: data['itemType'],
          uid: data['uid'],
          photo1: photo1,
          photo2: photo2,
          docId: item.id,
        ),
      );
    }
    return itemData;
  }

  //message queries

  Future<List<MessageReqData>> getMessageRequests(String uid) async {
    QuerySnapshot messageQuery = await FirebaseFirestore.instance
        .collection('messageReqData')
        .where('idTo', isEqualTo: uid)
        .get();

    QuerySnapshot messageQuery2 = await FirebaseFirestore.instance
        .collection('messageReqData')
        .where('idFrom', isEqualTo: uid)
        .get();

    List<MessageReqData> requests = [];

    requests.addAll(messageQuery.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return MessageReqData(
        idTo: data['idTo'],
        idFrom: data['idFrom'],
        itemId: data['itemId'],
        groupId: data['groupId'],
        docId: doc.id,
      );
    }));

    requests.addAll(messageQuery2.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return MessageReqData(
        idTo: data['idTo'],
        idFrom: data['idFrom'],
        itemId: data['itemId'],
        groupId: data['groupId'],
        docId: doc.id,
      );
    }));

    return requests;
  }

  createMessageReq(MessageReqData messageReqData) async {
    CollectionReference collRef =
        FirebaseFirestore.instance.collection('messageReqData');
    QuerySnapshot querySnapshot = await collRef.where('groupId', isEqualTo: messageReqData.groupId).get();
    var item = collRef.where('groupId', isEqualTo:  messageReqData.groupId);
    var item2 = await item.where('itemId', isEqualTo:  messageReqData.itemId).get();
    if(querySnapshot.docs.isEmpty || item2.docs.isEmpty){
      await collRef.add(
        messageReqData.toMap(),
      );
    }
  }

  sendMessage(String groupId, MessageData messageData) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('messageData')
        .doc(groupId)
        .collection(groupId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    final messageChat = MessageData(
      idFrom: messageData.idFrom,
      idTo: messageData.idTo,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      content: messageData.content,
      itemId: messageData.itemId,
    );

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  Stream<QuerySnapshot> getMessageStream(String groupId) {
    return FirebaseFirestore.instance
        .collection('messageData')
        .doc(groupId)
        .collection(groupId)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
