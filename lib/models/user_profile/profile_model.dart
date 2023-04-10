import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String? profile;
  String? dob;
  String? userName;
  String? email;
  String? phoneNo;
  String? uid;
  String? role;
  bool? isVerified;
  Timestamp? createdOn;

  ProfileModel({
    this.profile,
    this.dob,
    this.userName,
    this.email,
    this.phoneNo,
    this.uid,
    this.isVerified,
    this.role,
    this.createdOn,
  });

  ProfileModel.fromJson(Map json) {
    profile = json['profile'];
    dob = json['dob'];
    userName = json['userName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    uid = json['uid'];
    isVerified = json['isVerified'];
    role = json['role'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['profile'] = profile;
    data['dob'] = dob;
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['uid'] = uid;
    data['isVerified'] = isVerified;
    data['role'] = role;
    return data;
  }
}
