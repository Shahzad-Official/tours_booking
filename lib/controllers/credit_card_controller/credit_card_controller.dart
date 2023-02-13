import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreditCardController extends GetxController {
  String? date;

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
}
