import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tours_booking/services/get_user_data.dart';

import '../../models/user_profile/profile_model.dart';
import '../../utils/app_snackbar.dart';
import '../../views/main_page/main_page.dart';
import '../../views/registeration/login.dart';
import '../../views/registeration/sign_up.dart';
import 'login_service.dart';

class SignupService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GetUserData _userData = GetUserData();
  final LoginService _loginService = LoginService();
  List<ProfileModel> usersList = [];

  verifyUser({
    required String uid,
    required String email,
    required String displayName,
    required String photoURL,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        FirebaseFirestore.instance.collection("users").doc(uid).set({
          "email": email,
          "role": "user",
          "uid": uid,
          "userName": displayName,
          "profile": photoURL,
          "dob": "10-10-2000",
          "phoneNo": "+923000000000",
          "isVerified": false,
          "emailVerified": true,
          "created_on": DateTime.now(),
          "disabled": false,
          "commission": "5",
        });
        AppSnackbar.snackBar(title: "Message", message: "Successfully LogedIn");
        Get.offAll(() => const MainPage());
      } else {
        await _userData.getUserData(uid);

        if (_userData.userProfile.uid == null) {
          FirebaseFirestore.instance.collection("users").doc(uid).set({
            "email": email,
            "role": "user",
            "uid": uid,
            "userName": displayName,
            "profile": photoURL,
            "dob": "10-10-2000",
            "phoneNo": "+923000000000",
            "isVerified": false,
            "emailVerified": true,
            "created_on": DateTime.now(),
            "disabled": false,
            "commission": "5",
          });
          AppSnackbar.snackBar(
              title: "Message", message: "Successfully LogedIn");
          Get.offAll(() => const MainPage());
        } else if (_userData.userProfile.uid == uid &&
            _userData.userProfile.role == "lister") {
          AppSnackbar.snackBar(title: "Error", message: "User Already Exists.");
          _googleSignIn.signOut();
          Get.offAll(() => Login());
        } else if (_userData.userProfile.uid == uid &&
            _userData.userProfile.role == "user") {
          AppSnackbar.snackBar(title: "Error", message: "User Account Exists.");
          _googleSignIn.signOut();
          Get.offAll(() => Login());
        }
      }
    });
  }

  registerUser(
      {required String userName,
      required String email,
      required String phoneNo,
      required String password,
      required String confirmPassword}) async {
    try {
      UserCredential authCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await verifyUser(
        uid: authCredentials.user!.uid,
        email: email,
        displayName: userName,
        photoURL: "",
      );

      await _loginService.loginUser(email: email, password: password);
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
        await verifyUser(
          uid: user.user!.uid,
          email: user.user!.email!,
          displayName: user.user!.displayName!,
          photoURL: user.user!.photoURL!,
        );
      } else {}
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
        await verifyUser(
          uid: user.user!.uid,
          email: user.user!.email!,
          displayName: user.user!.displayName!,
          photoURL: user.user!.photoURL!,
        );
      } else {
        AppSnackbar.snackBar(title: "Message", message: "User Not available");
      }
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }
}
