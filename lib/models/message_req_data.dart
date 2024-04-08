class MessageReqData {
  String idTo;
  String idFrom;
  String itemId;
  String groupId;
  String? docId;

  MessageReqData(
      {required this.idTo,
      required this.idFrom,
      required this.itemId,
      this.docId,
      required this.groupId});

  Map<String, dynamic> toMap() {
    return {
      'idTo': idTo,
      'idFrom': idFrom,
      'itemId': itemId,
      'groupId': groupId,
    };
  }
}
