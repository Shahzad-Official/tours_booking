import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  Timestamp? createdOn;
  String? slotsBooked;
  String? totalPrice;
  String? tourId;
  String? userId;
  String? bookingId;

  BookingModel({
    this.createdOn,
    this.slotsBooked,
    this.totalPrice,
    this.tourId,
    this.userId,
    this.bookingId,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    createdOn = json['created_on'];
    slotsBooked = json['slots_booked'];
    totalPrice = json['total_price'];
    tourId = json['tour_id'];
    userId = json['user_id'];
    bookingId = json["booking_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['created_on'] = createdOn;
    data['slots_booked'] = slotsBooked;
    data['total_price'] = totalPrice;
    data['tour_id'] = tourId;
    data['user_id'] = userId;
    data["booking_id"] = bookingId;
    return data;
  }
}
