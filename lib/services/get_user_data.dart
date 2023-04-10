import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tours_booking/utils/app_snackbar.dart';
import '../models/user_profile/profile_model.dart';

class GetUserData {
  ProfileModel userProfile = ProfileModel();
  Box box = Hive.box("DataBox");
  Future<ProfileModel> getUserData(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) {
        if (value.data() == null) {
          userProfile = ProfileModel();
        } else {
          userProfile = ProfileModel.fromJson(value.data()!);
          if (box.isEmpty) {
            Map map = {
              "dob": userProfile.dob,
              "email": userProfile.email,
              "phone": userProfile.phoneNo,
              "profile": userProfile.profile,
              "uid": userProfile.uid,
              "userName": userProfile.userName,
            };

            box.put(
              "userData",
              map,
            );
          }
        }
      });
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error!");
    }
    return userProfile;
  }

  Future<String> getUserTermsAndConditions() async {
    String termsConditions = '';
    try {
      await FirebaseFirestore.instance
          .collection("terms_and_conditions")
          .doc("Users")
          .get()
          .then((value) {
        termsConditions = value.data()!["content"];
      });
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error!");
    }
    return termsConditions;
  }
}
