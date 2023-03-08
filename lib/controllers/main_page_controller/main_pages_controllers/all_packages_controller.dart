import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/services/package_services/get_all_packages.dart';

class AllPackagesController extends GetxController {
  GetAllPackages getAllPackages = GetAllPackages();
  List<PackagesModel> allPackages = [];
  List<PackagesModel> newPackagesList = [];
  bool isLoading = false;
  bool isSearching = false;

  searchPackage(String query, List<PackagesModel> packagesList) {
    Set<PackagesModel> set = packagesList.toSet();

    isSearching = true;
    update();

    if (packagesList.isNotEmpty) {
      if (query.trim().isEmpty) {
        isSearching = false;
        update();
        newPackagesList.clear();
      } else {
        var list = set
            .where(
              (element) => element.packageName!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
        newPackagesList = list;
      }
    } else {
      print("no package found");
    }
  }
}
