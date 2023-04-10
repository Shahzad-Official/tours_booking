import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tours_booking/services/booking_services.dart';

class CreditCardController extends GetxController {
  String? date;
  BookingServices bookingServices = BookingServices();
  currentDate() {
    var date = DateTime.now();
    var formatedDate = DateFormat("MM/yyyy").format(date);
    return formatedDate;
  }

  selectDate(context) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );

    if (selectedDate != null) {
      date = DateFormat("MM/yyyy").format(selectedDate);
    }

    update();
  }

  bool isLoading = false;

  makeBooking({
    required String totalPrice,
    required String tourId,
    required String bookedSlots,
    required String eventName,
  }) async {
    isLoading = true;
    update();
    await bookingServices.makeBooking(
      totalPrice: totalPrice,
      tourId: tourId,
      bookedSlots: bookedSlots,
      eventName: eventName,
    );
    isLoading = false;
    update();
  }
}
