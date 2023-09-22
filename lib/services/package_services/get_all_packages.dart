import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tours_booking/utils/app_snackbar.dart';

import '../../models/packages/packages_model.dart';

class GetAllPackages {
  List<PackagesModel> allPackages = [];
  Future<List<PackagesModel>> getAllPackages() async {
    allPackages.clear();
    try {
      await FirebaseFirestore.instance.collection("packages").where("isLive", isEqualTo: true).orderBy("created_on").get().then((value) {
        for (var i in value.docs) {
          allPackages.add(PackagesModel.fromJson(i.data()));
        }
      });
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
    return allPackages;
  }

  String totalRating = "0";
  PackagesModel packageData = PackagesModel();
  Future<PackagesModel> getPackageData(tourId) async {
    await FirebaseFirestore.instance.collection("packages").doc(tourId).get().then(
          (value) => packageData = PackagesModel.fromJson(
            value.data()!,
          ),
        );

    return packageData;
  }

  tourRating(tourId) async {
    double rating = 0.0;
    await FirebaseFirestore.instance
        .collection("reviews")
        .where(
          "tourId",
          isEqualTo: tourId,
        )
        .get()
        .then((value) {
      List ratings = [];
      for (var i in value.docs) {
        ratings.add(i.data()['rating']);
      }
      rating = ratings.fold(0.0, (p, e) => p + e);
    });
    return rating;
  }

  List<String> allCats = [];
  getAllCategories() async {
    allCats.clear();
    await FirebaseFirestore.instance.collection("category").get().then((value) {
      for (var i in value.docs) {
        allCats.add(i.data()['name']);
      }
    }).catchError((err) {
      debugPrint("error is $err");
    });
  }
}
