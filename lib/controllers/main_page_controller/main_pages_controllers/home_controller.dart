import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tours_booking/controllers/filter_sheet_controller.dart';
import 'package:tours_booking/main.dart';
import 'package:tours_booking/models/filter_model.dart';
import 'package:tours_booking/utils/calculate_distance.dart';
import 'dart:ui' as ui;

import '../../../models/packages/packages_model.dart';
import '../../../utils/date_utils.dart/calculate_days.dart';

class HomeController extends GetxController {
  List<PackagesModel> allPackages = [];
  final FilterSheetController _controller = Get.put(FilterSheetController());
  FilterModel filter = FilterModel();
  bool isTapped = false;
  double? latitude, longitude;
  bool isGettingLocation = false;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  checkIsTapped() {
    isTapped = !isTapped;
    update();
  }

  Uint8List? markerIcon;
  setCustomIcon() async {
    markerIcon = await getBytesFromAsset('assets/map_pin.png', 100);
    update();
  }

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
      }).catchError((err) {
        print(err);
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

  CameraPosition initialPosition({required double lat, required double long}) {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
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

  categorizePackage({String query = '', required List<PackagesModel> packagesList}) {
    allPackages = packagesList.where((element) {
      if (element.category == null) {
        return false;
      } else {
        return (element.category!.toLowerCase().contains(query.trim().toLowerCase()) &&
            calculateDays.daysBetweenDates(
                  endDate: element.endDate!,
                  endTime: element.endTime!,
                  startTime: element.startTime!,
                ) >
                0);
      }
    }).toList();

    update();
  }
}
