class ItemData {
  String title;
  String description;
  String itemType;
  String category;
  String location;
  String photo1;
  String photo2;
  String? docId;
  String uid;

  ItemData({
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.itemType,
    required this.uid,
    required this.photo1,
    required this.photo2,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'itemType': itemType,
      'category': category,
      'location': location,
      'photo1': photo1,
      'photo2': photo2,
      'uid': uid,
    };
  }
}
