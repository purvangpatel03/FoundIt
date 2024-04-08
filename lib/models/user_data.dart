class UserData{
  String name;
  String email;
  String? phoneNo;
  String uid;
  String? docId;
  String? photoURL;

  UserData({required this.name, required this.email, this.docId,required this.uid, this.phoneNo, this.photoURL});

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'uid': uid,
      'photoURL': photoURL,
    };
  }

}