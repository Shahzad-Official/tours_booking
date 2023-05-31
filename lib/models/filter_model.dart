class FilterModel {
  List<int>? distanceRangs;
  List<int>? priceRanges;
  String? type;
  String? dangerRating;
  int? days;

  FilterModel({this.distanceRangs, this.priceRanges, this.type, this.dangerRating, this.days});

  FilterModel.fromJson(Map<String, dynamic> json) {
    distanceRangs = json['DistanceRangs'].cast<int>();
    priceRanges = json['PriceRanges'].cast<int>();
    type = json['Type'];
    dangerRating = json['DangerRating'];
    days = json['Days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['DistanceRangs'] = distanceRangs;
    data['PriceRanges'] = priceRanges;
    data['Type'] = type;
    data['DangerRating'] = dangerRating;
    data['Days'] = days;
    return data;
  }
}
