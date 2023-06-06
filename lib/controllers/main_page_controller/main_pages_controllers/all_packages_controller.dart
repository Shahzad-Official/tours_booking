import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_booking/controllers/filter_sheet_controller.dart';
import 'package:tours_booking/models/filter_model.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/services/package_services/get_all_packages.dart';
import 'package:tours_booking/utils/calculate_distance.dart';
import 'package:tours_booking/utils/date_utils.dart/calculate_days.dart';

import '../../../main.dart';

class AllPackagesController extends GetxController {
  GetAllPackages getAllPackages = GetAllPackages();
  List<PackagesModel> allPackages = [];
  final FilterSheetController _controller = Get.put(FilterSheetController());
  FilterModel filter = FilterModel();
  applyFilter({
    String query = '',
    required List<PackagesModel> packagesList,
  }) {
    var data = jsonEncode({
      "DistanceRangs": [
        _controller.rangeValues.start.round(),
        _controller.rangeValues.end.round(),
      ],
      "PriceRanges": [
        _controller.rangePriceValues.start.round(),
        _controller.rangePriceValues.end.round(),
      ],
      "Type": _controller.tourType,
      "DangerRating": _controller.tourRisk,
      "Days": _controller.days,
    });
    filter = FilterModel.fromJson(jsonDecode(data));
    debugPrint("Filter => ${filter.dangerRating}");
    searchPackage(
      packagesList: packagesList,
      filters: filter,
    );
    Get.back();
  }

  CalculateDays calculateDays = CalculateDays();
  searchPackage({
    String query = '',
    required List<PackagesModel> packagesList,
    FilterModel? filters,
  }) {
    double latitude = box.get("latitude");
    double longitude = box.get("longitude");
    allPackages = packagesList.where((element) {
      int days = calculateDays.daysBetweenDates(
        endDate: element.endDate!,
        endTime: element.endTime!,
        startTime: element.startTime!,
      );

      if (days < 0) {
        return false;
      } else if (filters == null) {
        return (element.packageName!.toLowerCase().contains(query.trim().toLowerCase()));
      } else {
        int distance = CalculateDistance.calculateDistance(
          latitude,
          longitude,
          element.location!.latitude!,
          element.location!.longitude!,
        ).round();

        double price = double.parse(element.endPrice!);

        return (element.packageName!.toLowerCase().contains(
                  query.trim().toLowerCase(),
                ) &&
            element.typeOfTour!.toLowerCase().contains(
                  filters.type!.toLowerCase(),
                ) &&
            element.dangerRating!.toLowerCase().contains(
                  filters.dangerRating!.toLowerCase(),
                ) &&
            (distance >= filters.distanceRangs!.first.toDouble() && distance <= filters.distanceRangs![1].toDouble()) &&
            (price >= filters.priceRanges!.first.toDouble() && price <= filters.priceRanges![1].toDouble()) &&
            days == filters.days);
      }
    }).toList();
    update();
  }
}
