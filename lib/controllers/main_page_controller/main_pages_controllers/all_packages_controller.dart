import 'package:get/get.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/services/package_services/get_all_packages.dart';

class AllPackagesController extends GetxController {
  GetAllPackages getAllPackages = GetAllPackages();
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
