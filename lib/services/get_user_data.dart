import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile/profile_model.dart';

class GetUserData {
  ProfileModel userProfile = ProfileModel();
  getUserData(String uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      userProfile = ProfileModel.fromJson(value.data()!);
    });
  }
}
