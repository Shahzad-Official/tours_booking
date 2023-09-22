import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tours_booking/utils/app_snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthenticationServices {
  var user = FirebaseAuth.instance.currentUser;

  updateProfile(
    String uid, {
    required String email,
    required String name,
    required String phone,
    required String dob,
    required File image,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update(
        {
          "email": email,
          "userName": name,
          "phoneNo": phone,
          "dob": dob,
          "profile": "",
        },
      ).then(
        (value) async {
          await FirebaseStorage.instance.ref("users_profiles").child(uid).putFile(image).then(
            (res) async {
              var url = await res.ref.getDownloadURL();
              await FirebaseFirestore.instance.collection("users").doc(uid).update(
                {"profile": url},
              );
            },
          );
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  forgetPassword({required String email}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then(
          (value) => AppSnackbar.snackBar(title: "Message", message: "The reset password link has been sent to your email!"),
        )
        .catchError((err) {
      AppSnackbar.snackBar(title: "Error", message: err.toString());
    });
  }
}
