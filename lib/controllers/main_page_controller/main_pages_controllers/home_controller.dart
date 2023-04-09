import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import '../../../models/packages/packages_model.dart';
import '../../../services/package_services/get_all_packages.dart';

class HomeController extends GetxController {
  bool isTapped = false;
  double? latitude, longitude;
  bool isGettingLocation = false;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getDouble("latitude") == null) {
      isGettingLocation = true;
      update();
      await Permission.location.request();
      await Geolocator.getCurrentPosition().then((value) {
        preferences.setDouble("latitude", value.latitude);
        preferences.setDouble("longitude", value.longitude);
        latitude = preferences.getDouble("latitude");
        longitude = preferences.getDouble("longitude");
        update();
      });
      isGettingLocation = false;

      update();
    } else {
      isGettingLocation = true;
      update();
      latitude = preferences.getDouble("latitude");
      longitude = preferences.getDouble("longitude");
      update();
      isGettingLocation = false;

      update();
    }
  }

  CameraPosition initialPosition() {
    return CameraPosition(
      target: LatLng(latitude!, longitude!),
      zoom: 14.4746,
    );
  }

  List<PackagesModel> allPackages = [];

  searchPackage(
      {String query = '', required List<PackagesModel> packagesList}) {
    allPackages = packagesList.where((element) {
      return element.packageName!
          .toLowerCase()
          .contains(query.trim().toLowerCase());
    }).toList();
    update();
  }
}
