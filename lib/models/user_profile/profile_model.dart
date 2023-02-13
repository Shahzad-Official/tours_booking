class ProfileModel {
  String? profile;
  String? dob;
  String? userName;
  String? email;
  String? phoneNo;
  String? uid;
  bool? isVerified;

  ProfileModel({
    this.profile,
    this.dob,
    this.userName,
    this.email,
    this.phoneNo,
    this.uid,
    this.isVerified,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    profile = json['profile'];
    dob = json['dob'];
    userName = json['userName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    uid = json['uid'];
    isVerified = json['isVerified'];
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
    return data;
  }
}
