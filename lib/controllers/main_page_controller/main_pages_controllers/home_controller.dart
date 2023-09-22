import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tours_booking/main.dart';
import 'dart:ui' as ui;

import '../../../models/packages/packages_model.dart';
import '../../../utils/date_utils.dart/calculate_days.dart';

class HomeController extends GetxController {
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

  List<PackagesModel> allPackages = [];
  CalculateDays calculateDays = CalculateDays();
  searchPackage({String query = '', required List<PackagesModel> packagesList}) {
    getMyCurrentLocation();
    allPackages = packagesList.where((element) {
      return (element.location!.address!.toLowerCase().contains(query.trim().toLowerCase()) &&
          calculateDays.daysBetweenDates(
                endDate: element.endDate!,
                endTime: element.endTime!,
                startTime: element.startTime!,
              ) >
              0);
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
