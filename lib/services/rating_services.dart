import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingServices {
  giveRating({
    required String tourId,
    required double rating,
    required String feedBack,
  }) async {
    await FirebaseFirestore.instance.collection("ratings").add(
      {
        "rating": rating,
        "tourId": tourId,
        "feedBack": feedBack,
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "id": ""
      },
    ).then(
      (value) async => await FirebaseFirestore.instance
          .collection("ratings")
          .doc(value.id)
          .update(
        {
          "id": value.id,
        },
      ),
    );
  }
}
