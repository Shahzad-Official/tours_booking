import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/packages/packages_model.dart';

class GetAllPackages {
  List<PackagesModel> allPackages = [];
  Future<List<PackagesModel>> getAllPackages() async {
    allPackages.clear();
    await FirebaseFirestore.instance
        .collection("packages")
        .where("listerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("created_on")
        .get()
        .then((value) {
      for (var i in value.docs) {
        allPackages.add(PackagesModel.fromJson(i.data()));
      }
    });
    return allPackages;
  }

  Stream<List<PackagesModel>> getPackagesList() {
    var list = FirebaseFirestore.instance
        .collection('packages')
        .where("listerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map(
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
