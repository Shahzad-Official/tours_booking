import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_booking/services/reviews_services.dart';

class FeedbackController extends GetxController {
  TextEditingController feedBack = TextEditingController();
  final ReviewsServices _reviewsServices = ReviewsServices();
  double currentRating = 0;
  updateRating(double rating) {
    currentRating = rating;
    update();
  }

  bool isLoading = false;
  giveFeedBack({
    required String tourId,
  }) async {
    isLoading = true;
    update();
    await _reviewsServices.giveRating(
      tourId: tourId,
      rating: currentRating,
      feedBack: feedBack.text,
    );
    isLoading = false;
    update();
  }
}
