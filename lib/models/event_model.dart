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
