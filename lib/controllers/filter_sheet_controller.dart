import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterSheetController extends GetxController {
  RangeValues rangeValues = const RangeValues(0, 0);
  changeValues(RangeValues values) {
    rangeValues = values;
    update();
  }

  String tourType = "Individual";
  int currentTypeIndex = 0;
  changeType(int index, String type) {
    currentTypeIndex = index;
    tourType = type;
    update();
  }

  String tourRisk = "1";
  int currentRiskIndex = 0;
  changeRisk(int index) {
    currentRiskIndex = index;
    tourRisk = "${index + 1}";
    update();
  }

  int days = 1;
  int currentDaysIndex = 0;
  changeDays(int index, int day) {
    days = day;
    currentDaysIndex = index;
    update();
  }

  RangeValues rangePriceValues = const RangeValues(0, 0);
  changePriceValues(RangeValues values) {
    rangePriceValues = values;
    update();
  }
}
