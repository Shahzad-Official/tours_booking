class ReviewModel {
  String? feedBack;
  String? tourId;
  double? rating;
  String? id;
  String? userId;
  String? createdOn;

  ReviewModel({
    this.feedBack,
    this.tourId,
    this.rating,
    this.id,
    this.userId,
    this.createdOn,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    feedBack = json['feedBack'];
    tourId = json['tourId'];
    rating = json['rating'];
    id = json['id'];
    userId = json['userId'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['feedBack'] = feedBack;
    data['tourId'] = tourId;
    data['rating'] = rating;
    data['id'] = id;
    data['userId'] = userId;
    data['createdOn'] = createdOn;
    return data;
  }
}
