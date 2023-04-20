import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tours_booking/services/booking_services.dart';
import 'package:tours_booking/utils/app_snackbar.dart';

import '../../constants/app_colors.dart';
import '../../views/main_page/main_page.dart';
import '../../widgets/app_text.dart';

class CreditCardController extends GetxController {
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController expiryDate = TextEditingController();

  BookingServices bookingServices = BookingServices();
  currentDate() {
    var date = DateTime.now();
    var formatedDate = DateFormat("MM/yyyy").format(date);
    expiryDate.text = formatedDate;
    update();
    return formatedDate;
  }

  selectDate(context) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (selectedDate != null) {
      expiryDate.text = DateFormat("MM/yyyy").format(selectedDate);
    }

    update();
  }

  bool isLoading = false;

  makeBooking(
    context, {
    required String totalPrice,
    required String tourId,
    required String listerId,
    required String bookedSlots,
    required String eventName,
  }) async {
    if (cardNumber.text.trim().isEmpty || cardNumber.text.trim().length < 16) {
      AppSnackbar.snackBar(title: "Error", message: "Enter valid Card Number!");
    } else if (expiryDate.text.isEmpty) {
      AppSnackbar.snackBar(
          title: "Error", message: "Please enter card expiry Date!");
    } else if (cvv.text.trim().isEmpty || cvv.text.trim().length < 3) {
      AppSnackbar.snackBar(
          title: "Error", message: "Please enter valid CVV number!");
    } else {
      isLoading = true;
      update();
      try {
        await FirebaseFunctions.instance.httpsCallable("stripePayment").call({
          "number": cardNumber.text.trim(),
          "amount": int.parse(totalPrice),
          "month": expiryDate.text.split("/").first,
          "year": expiryDate.text.split("/").last,
          "description": "Booked A Tour",
          "cvv": cvv.text,
        });
        AppSnackbar.snackBar(
          title: "Message",
          message: "Payment Done Successfully!",
        );
      } on FirebaseFunctions catch (e) {
        AppSnackbar.snackBar(
          title: "Error",
          message: e.toString(),
        );
      }
      await bookingServices.makeBooking(
        totalPrice: totalPrice,
        tourId: tourId,
        bookedSlots: bookedSlots,
        eventName: eventName,
        listerId: listerId,
      );
      isLoading = false;
      update();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const AppText(
            text: "Success!",
            textcolor: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          content: const AppText(
            text: "Booking confirmed; Invoice sent via mail.",
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primarycolor),
              ),
              child: const AppText(text: "OK"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(
                      currentIndex: 2,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }
}
