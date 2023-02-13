import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    await FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.any(
        (element) {
          if (element.id == uId) {
            _userData.getUserData(uId);
            if (element.data()["email"] == _userData.userProfile.email &&
                element.data()['role'] == "user") {
              AppSnackbar.snackBar(
                  title: "Error", message: "User Already Exists.");
              Get.offAll(() => Login());
              return true;
            } else if (element.data()["email"] == _userData.userProfile.email &&
                element.data()['role'] == "lister") {
              AppSnackbar.snackBar(
                  title: "Message", message: "Successfully LogedIn");
              Get.offAll(() => const MainPage());
              return true;
            } else {
              return false;
            }
          } else {
            AppSnackbar.snackBar(
                title: "Message", message: "User not available! SignUp first");
            Get.offAll(() => SignUp());
            return false;
          }
        },
      );
    });
  }

  static loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppSnackbar.snackBar(title: "Message", message: "Successfully LogedIn");
      Get.offAll(() => const MainPage());
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
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
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  faceBookLoginService() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      var user =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      var userId = user.user!.uid;
      doesContainId(userId);
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }
}
