import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tours_booking/models/booking_model.dart';
import 'package:tours_booking/utils/app_snackbar.dart';

class BookingServices {
  int notificationCount = 0;
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
    required Timestamp createdOn,
    required String totalPrice,
    required String tourId,
    required String userId,
  }) async {
    BookingModel bookingModel = BookingModel(
      createdOn: createdOn,
      slotsBooked: "2",
      totalPrice: totalPrice,
      tourId: tourId,
      userId: userId,
    );

    try {
      await FirebaseFirestore.instance
          .collection("bookings")
          .add(bookingModel.toJson())
          .then(
        (value) async {
          await FirebaseFirestore.instance
              .collection("bookings")
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
              "user_id": userId,
              "status": "unseen",
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
