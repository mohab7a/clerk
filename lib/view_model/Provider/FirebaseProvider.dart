import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStoreProvider extends ChangeNotifier {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Map<String, dynamic> data;

  void updateData({
    String key,
    value,
  }) {
    _fireStore
        .collection("Users")
        .doc(_auth.currentUser.email)
        .update({key: value});
    notifyListeners();
  }

  Future getData() async {
    final DocumentReference document = FirebaseFirestore.instance
        .collection("Users")
        .doc(_auth.currentUser.email);
    await document.get().then((snapshot) async {
      data = snapshot.data();
      notifyListeners();
    });
  }


  Future firebaseStorage({image, context}) async {
    TaskSnapshot snapshot = await _firebaseStorage
        .ref()
        .child(_auth.currentUser.email)
        .putFile(image);
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(_auth.currentUser.email)
          .update({"userImage": downloadUrl});
      notifyListeners();
    }
  }
}
