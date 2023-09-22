import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/services/booking_services.dart';
import 'package:tours_booking/services/payment_services.dart';
import 'package:tours_booking/utils/app_snackbar.dart';
import 'package:tours_booking/views/main_page/main_page.dart';
import 'package:tours_booking/widgets/app_text.dart';

class CreditCardController extends GetxController {
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController name = TextEditingController();
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

  PaymentServices services = PaymentServices();
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
      AppSnackbar.snackBar(title: "Error", message: "Please enter card expiry Date!");
    } else if (cvv.text.trim().isEmpty || cvv.text.trim().length < 3) {
      AppSnackbar.snackBar(title: "Error", message: "Please enter valid CVV number!");
    } else {
      isLoading = true;
      update();
      await services.makePayment(
        cardNumber: cardNumber.text,
        month: expiryDate.text.split("/").first,
        year: expiryDate.text.split("/").last,
        cvc: cvv.text,
        amount: totalPrice,
        name: name.text,
      );
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
                backgroundColor: MaterialStateProperty.all(AppColors.primarycolor),
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
      isLoading = false;
      update();
    }
  }
}
