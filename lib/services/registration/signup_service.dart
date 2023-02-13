import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/dummy_data.dart';
import '../../utils/app_snackbar.dart';
import '../../views/main_page/main_page.dart';
import 'login_service.dart';

class SignupService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  registerUser(
      {required String userName,
      required String email,
      required String phoneNo,
      required String password,
      required String confirmPassword}) async {
    try {
      UserCredential authCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(authCredentials.user!.uid)
          .set({
        "profile": DummyData.profilePic,
        "userName": userName,
        "dob": "01-01-2000",
        "uid": authCredentials.user!.uid,
        "email": email,
        "phoneNo": phoneNo,
        "isVerified": false,
        "emailVerified": false,
        "created_on": DateTime.now(),
        "disabled": false,
        "commission": "5",
        "role": "user",
      });

      await LoginService.loginUser(email: email, password: password);
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  googleSignUpService() async {
    try {
      var googleSignInAccount = await _googleSignIn.signIn();
      var googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var user = await _firebaseAuth.signInWithCredential(credential);
      if (user.user != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.user!.uid)
            .set({
          "email": user.user!.email,
          "uid": user.user!.uid,
          "userName": user.user!.displayName,
          "profile": user.user!.photoURL,
          "dob": "10-10-2000",
          "phoneNo": "+923000000000",
          "isVerified": false,
          "emailVerified": true,
          "created_on": DateTime.now(),
          "disabled": false,
          "commission": "5",
          "role": "user",
        });
        AppSnackbar.snackBar(title: "Message", message: "Successfully LogedIn");
        Get.offAll(() => MainPage());
      } else {
        AppSnackbar.snackBar(title: "Message", message: "User Not available");
      }
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  faceBookSignUpService() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      var user = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      if (user.user != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.user!.uid)
            .set({
          "email": user.user!.email,
          "uid": user.user!.uid,
          "userName": user.user!.displayName,
          "profile": user.user!.photoURL,
          "dob": "10-10-2000",
          "phoneNo": "+923000000000",
          "isVerified": false,
          "emailVerified": true,
          "created_on": DateTime.now(),
          "disabled": false,
          "commission": "5",
          "role": "user",
        });
        AppSnackbar.snackBar(title: "Message", message: "Successfully LogedIn");
        Get.offAll(() => MainPage());
      } else {
        AppSnackbar.snackBar(title: "Message", message: "User Not available");
      }
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }
}
