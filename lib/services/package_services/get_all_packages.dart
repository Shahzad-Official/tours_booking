import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tours_booking/utils/app_snackbar.dart';

import '../../models/packages/packages_model.dart';

class GetAllPackages {
  List<PackagesModel> allPackages = [];
  Future<List<PackagesModel>> getAllPackages() async {
    allPackages.clear();
    try {
      await FirebaseFirestore.instance
          .collection("packages")
          .where("isLive", isEqualTo: true)
          .orderBy("created_on")
          .get()
          .then((value) {
        for (var i in value.docs) {
          allPackages.add(PackagesModel.fromJson(i.data()));
        }
      });
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
    return allPackages;
  }

  PackagesModel packageData = PackagesModel();
  Future<PackagesModel> getPackageData(tourId) async {
    await FirebaseFirestore.instance
        .collection("packages")
        .doc(tourId)
        .get()
        .then(
          (value) => packageData = PackagesModel.fromJson(
            value.data()!,
          ),
        );

    return packageData;
  }
}
