import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  String idFrom;
  String idTo;
  int timestamp;
  String content;
  String itemId;

  MessageData({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.itemId,
  });

  Map<String, dynamic> toJson() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      'itemId': itemId,
    };
  }

  factory MessageData.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get('idFrom');
    String idTo = doc.get('idTo');
    int timestamp = doc.get('timestamp');
    String content = doc.get('content');
    String itemId = doc.get('itemId');
    return MessageData(
      idFrom: idFrom,
      idTo: idTo,
      timestamp: timestamp,
      content: content,
      itemId: itemId,
    );
  }
}
