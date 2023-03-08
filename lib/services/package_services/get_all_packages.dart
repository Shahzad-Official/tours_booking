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

  Stream<List<PackagesModel>> getPackagesList() {
    var list =
        FirebaseFirestore.instance.collection('packages').snapshots().map(
              (snapShot) => snapShot.docs
                  .map(
                    (document) => PackagesModel.fromJson(
                      document.data(),
                    ),
                  )
                  .toList(),
            );
    return list;
  }
}
