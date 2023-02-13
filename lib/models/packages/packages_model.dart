import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? name;
  String? startDate;
  String? endDate;
  String? location;
  String? startPrice;
  String? endPrice;
  String? cuttoffTime;
  String? allowedNoOfBookings;
  String? dangerRating;
  String? ageSuitability;
  String? catagory;
  String? termsAndConditions;
  String? coverImage;
  bool? isLive;
  List<Users>? users;

  EventModel(
      {this.name,
      this.startDate,
      this.endDate,
      this.location,
      this.startPrice,
      this.endPrice,
      this.cuttoffTime,
      this.allowedNoOfBookings,
      this.dangerRating,
      this.ageSuitability,
      this.catagory,
      this.termsAndConditions,
      this.coverImage,
      this.isLive,
      this.users});

  EventModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    location = json['location'];
    startPrice = json['startPrice'];
    endPrice = json['endPrice'];
    cuttoffTime = json['cuttoffTime'];
    allowedNoOfBookings = json['allowedNoOfBookings'];
    dangerRating = json['dangerRating'];
    ageSuitability = json['ageSuitability'];
    catagory = json['catagory'];
    termsAndConditions = json['termsAndConditions'];
    coverImage = json['coverImage'];
    isLive = json['isLive'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['location'] = location;
    data['startPrice'] = startPrice;
    data['endPrice'] = endPrice;
    data['cuttoffTime'] = cuttoffTime;
    data['allowedNoOfBookings'] = allowedNoOfBookings;
    data['dangerRating'] = dangerRating;
    data['ageSuitability'] = ageSuitability;
    data['catagory'] = catagory;
    data['termsAndConditions'] = termsAndConditions;
    data['coverImage'] = coverImage;
    data['isLive'] = isLive;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? name;
  String? pic;
  String? email;
  String? phoneNo;
  String? gender;
  String? dOB;

  Users({this.name, this.pic, this.email, this.phoneNo, this.gender, this.dOB});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pic = json['pic'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    gender = json['gender'];
    dOB = json['DOB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['pic'] = pic;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['gender'] = gender;
    data['DOB'] = dOB;
    return data;
  }
}

class PackagesModel {
  String? startDate;
  String? noOfPersonsInPackage;
  String? listerId;
  String? extraInfo;
  String? endPrice;
  Timestamp? createdOn;
  List<String>? otherImage;
  String? endDate;
  String? dangerRating;
  String? packageName;
  bool? isLive;
  String? thumbnailUrl;
  String? packageId;
  String? typeOfTour;
  String? ageSuitability;
  String? foodServed;
  String? startTime;
  String? endTime;
  Location? location;
  String? startPrice;
  String? termsAndConditions;
  String? cuttOffTime;

  PackagesModel({
    this.startDate,
    this.noOfPersonsInPackage,
    this.listerId,
    this.extraInfo,
    this.endPrice,
    this.otherImage,
    this.endDate,
    this.dangerRating,
    this.packageName,
    this.isLive,
    this.thumbnailUrl,
    this.packageId,
    this.typeOfTour,
    this.ageSuitability,
    this.foodServed,
    this.startTime,
    this.endTime,
    this.location,
    this.startPrice,
    this.termsAndConditions,
    this.createdOn,
    this.cuttOffTime,
  });

  PackagesModel.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    noOfPersonsInPackage = json['noOfPersonsInPackage'];
    listerId = json['listerId'];
    extraInfo = json['extraInfo'];
    endPrice = json['endPrice'];
    otherImage = json['otherImage'].cast<String>();
    endDate = json['endDate'];
    dangerRating = json['dangerRating'];
    packageName = json['packageName'];
    isLive = json['isLive'];
    thumbnailUrl = json['thumbnailUrl'];
    packageId = json['packageId'];
    typeOfTour = json['typeOfTour'];
    ageSuitability = json['ageSuitability'];
    foodServed = json['foodServed'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    startPrice = json['startPrice'];
    termsAndConditions = json['termsAndConditions'];
    cuttOffTime = json['cuttOffTime'];
    createdOn = json["created_on"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['startDate'] = startDate;
    data['noOfPersonsInPackage'] = noOfPersonsInPackage;
    data['listerId'] = listerId;
    data['extraInfo'] = extraInfo;
    data['created_on'] = createdOn;
    data['endPrice'] = endPrice;
    data['otherImage'] = otherImage;
    data['endDate'] = endDate;
    data['dangerRating'] = dangerRating;
    data['packageName'] = packageName;
    data['isLive'] = isLive;
    data['thumbnailUrl'] = thumbnailUrl;
    data['packageId'] = packageId;
    data['typeOfTour'] = typeOfTour;
    data['ageSuitability'] = ageSuitability;
    data['foodServed'] = foodServed;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['startPrice'] = startPrice;
    data['termsAndConditions'] = termsAndConditions;
    data['cuttOffTime'] = cuttOffTime;
    return data;
  }
}

class Location {
  String? address;
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude, this.address});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data["address"] = address;
    return data;
  }
}
