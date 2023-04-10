import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/review_model.dart';

class ReviewsServices {
  List<ReviewModel> allReviews = [];
  getAllReviews(String tourId) async {
    allReviews.clear();
    await FirebaseFirestore.instance
        .collection("reviews")
        .where(
          "tourId",
          isEqualTo: tourId,
        )
        .get()
        .then(
      (value) {
        for (var i in value.docs) {
          allReviews.add(
            ReviewModel.fromJson(
              i.data(),
            ),
          );
        }
      },
    );
  }

  giveRating({
    required String tourId,
    required double rating,
    required String feedBack,
  }) async {
    await FirebaseFirestore.instance.collection("reviews").add(
      {
        "rating": rating,
        "tourId": tourId,
        "feedBack": feedBack,
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "createdOn": DateTime.now().toLocal().toString(),
        "id": ""
      },
    ).then(
      (value) async => await FirebaseFirestore.instance
          .collection("reviews")
          .doc(value.id)
          .update(
        {
          "id": value.id,
        },
      ),
    );
  }
}
