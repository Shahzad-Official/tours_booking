import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../utils/app_snackbar.dart';

class PaymentServices {
  makePayment({
    required String cardNumber,
    required String month,
    required String year,
    required String cvc,
    required String amount,
    required String name,
  }) async {
    var data = jsonEncode({
      "number": cardNumber,
      "month": month,
      "year": year,
      "cvc": cvc,
      "amount": (double.parse(amount) * 100).toInt(),
      'name': name,
    });

    await post(
      Uri.parse("https://us-central1-go-17dd4.cloudfunctions.net/payNow"),
      headers: {'Content-Type': 'application/json'},
      body: data,
    ).then((value) async {
      var data = jsonDecode(value.body);
      print(data);
      if (data['result'] != null) {
      } else {
        debugPrint("Error is ${data['error']}");
        AppSnackbar.snackBar(
          title: "Error",
          message: data['error'].toString(),
        );
      }
    }).catchError((err) {
      debugPrint("Request Error $err");
    });
  }
}
