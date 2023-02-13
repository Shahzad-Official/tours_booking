import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/app_snackbar.dart';
import '../../views/main_page/main_page.dart';
import '../../views/registeration/sign_up.dart';

class LoginService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  doesContainId(uId) async {
    var lis = await FirebaseFirestore.instance.collection("listers").get();
    var res = lis.docs.any((element) => element.id == uId);

    if (res) {
      AppSnackbar.snackBar(title: "Message", message: "Successfully LogedIn");
      Get.offAll(() => MainPage());
    } else {
      AppSnackbar.snackBar(
          title: "Message", message: "User not available! SignUp first");
      Get.offAll(() => SignUp());
    }
    return res;
  }

  static loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppSnackbar.snackBar(title: "Message", message: "Successfully LogedIn");
      Get.offAll(() => MainPage());
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
