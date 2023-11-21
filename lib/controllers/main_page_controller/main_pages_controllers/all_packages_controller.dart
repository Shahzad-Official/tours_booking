import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
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
  double? latitude, longitude;
  bool isGettingLocation = false;
  getMyCurrentLocation() async {
    if (box.get("latitude") == null) {
      isGettingLocation = true;
      update();
      await Permission.location.request();
      await Geolocator.requestPermission();
      await Geolocator.getCurrentPosition().then((value) {
        box.put("latitude", value.latitude);
        box.put("longitude", value.longitude);
        latitude = box.get("latitude");
        longitude = box.get("longitude");
        update();
      });
      isGettingLocation = false;

      update();
    } else {
      isGettingLocation = true;
      update();
      latitude = box.get("latitude");
      longitude = box.get("longitude");
      update();
      isGettingLocation = false;

      update();
    }
  }

  applyFilter({
    String query = '',
    required List<PackagesModel> packagesList,
  }) async {
    await getMyCurrentLocation();
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
    double latitude = box.get("latitude") ?? 40.9006;
    double longitude = box.get("longitude") ?? 174.8860;

    allPackages = packagesList.where((element) {
      int days = calculateDays.daysBetweenDates(
        endDate: element.endDate!,
        endTime: element.endTime!,
        startTime: element.startTime!,
      );

      if (calculateDays.isHours || days < 0) {
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
