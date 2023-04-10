import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tours_booking/models/booking_model.dart';
import 'package:tours_booking/utils/app_snackbar.dart';

class BookingServices {
  int notificationCount = 0;
  List<BookingModel> allBookings = [];
  getAllBookings() async {
    try {
      await FirebaseFirestore.instance.collection("booking").get().then(
        (value) {
          for (var i in value.docs) {
            allBookings.add(
              BookingModel.fromJson(
                i.data(),
              ),
            );
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
  }

  getNotificationCount() async {
    try {
      await FirebaseFirestore.instance
          .collection("notifications")
          .where("status", isNotEqualTo: "seen")
          .get()
          .then(
        (value) {
          notificationCount = value.docs.length;
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
  }

  makeBooking({
    required String totalPrice,
    required String tourId,
    required String bookedSlots,
    required String eventName,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("booking").add(
        {
          "slots_booked": bookedSlots,
          "user_id": FirebaseAuth.instance.currentUser!.uid,
          "tour_id": tourId,
          "booking_id": "",
          "created_on": Timestamp.fromDate(
            DateTime.now(),
          ),
          "message": "Booked a tour",
          "total_price": totalPrice,
          "eventName": eventName,
        },
      ).then(
        (value) async {
          await FirebaseFirestore.instance
              .collection("booking")
              .doc(value.id)
              .set(
            {
              "booking_id": value.id,
            },
            SetOptions(
              merge: true,
            ),
          );
        },
      ).then(
        (value2) async {
          await FirebaseFirestore.instance.collection("notifications").add(
            {
              "tour_id": tourId,
              "user_id": FirebaseAuth.instance.currentUser!.uid,
              "status": "unseen",
              "message": "Booked a tour",
              "id": "",
            },
          ).then(
            (value) async {
              await FirebaseFirestore.instance
                  .collection("notifications")
                  .doc(value.id)
                  .update(
                {
                  "id": value.id,
                },
              );
            },
          );
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
  }

  changeNotificationStatus(String notId) async {
    try {
      await FirebaseFirestore.instance
          .collection("notifications")
          .doc(notId)
          .update(
        {
          "status": "seen",
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error!");
    }
  }

  giveRatings({
    required String tourId,
    required String userId,
    required double rating,
    required DateTime currentDate,
    required String feedBack,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("ratings").add(
        {
          "tour_id": tourId,
          "user_id": userId,
          "id": "",
          "rating": rating,
          "created_on": currentDate,
          "feedback": feedBack,
        },
      ).then(
        (value) async {
          await FirebaseFirestore.instance
              .collection("ratings")
              .doc(value.id)
              .update(
            {
              "id": value.id,
            },
          );
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error!");
    }
  }
}
