import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:tours_booking/services/get_user_data.dart';

import '../../utils/app_snackbar.dart';
import '../../views/main_page/main_page.dart';
import '../../views/registeration/login.dart';
import '../../views/registeration/sign_up.dart';

class LoginService {
  final GetUserData _userData = GetUserData();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  doesContainId(uId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        AppSnackbar.snackBar(
            title: "Message", message: "User not available! SignUp first");
        _googleSignIn.signOut();
        Get.offAll(() => const SignUp());
      } else {
        await _userData.getUserData(uId);

        if (_userData.userProfile.uid == null) {
          AppSnackbar.snackBar(
              title: "Message", message: "User not available! SignUp first");
          _googleSignIn.signOut();
          Get.offAll(() => const SignUp());
        } else if (_userData.userProfile.uid == uId &&
            _userData.userProfile.role == "lister") {
          AppSnackbar.snackBar(title: "Error", message: "User Already Exists.");
          _googleSignIn.signOut();
          Get.offAll(() => const Login());
          return true;
        } else if (_userData.userProfile.uid == uId &&
            _userData.userProfile.role == "user") {
          AppSnackbar.snackBar(
              title: "Message", message: "Successfully LogedIn");
          Get.offAll(() => const MainPage());
          return true;
        }
      }
    });
  }

  loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => doesContainId(value.user!.uid),
          );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
  }

  googleSignInService() async {
    try {
      var googleSignInAccount = await _googleSignIn.signIn();
      var googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var user = await _firebaseAuth.signInWithCredential(credential);
      var userId = user.user!.uid;
      doesContainId(userId);
    } catch (e) {
      AppSnackbar.snackBar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  faceBookLoginService() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _firebaseAuth.signInWithCredential(facebookAuthCredential).then(
            (value) => doesContainId(value.user!.uid),
          );
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(
        title: "Error",
        message: e.toString(),
      );
    }
  }
}
