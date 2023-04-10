import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  Timestamp? createdOn;
  String? slotsBooked;
  String? totalPrice;
  String? tourId;
  String? userId;
  String? bookingId;
  String? message;
  String? eventName;

  BookingModel({
    this.createdOn,
    this.slotsBooked,
    this.totalPrice,
    this.tourId,
    this.userId,
    this.bookingId,
    this.message,
    this.eventName,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    createdOn = json['created_on'];
    slotsBooked = json['slots_booked'];
    totalPrice = json['total_price'];
    tourId = json['tour_id'];
    userId = json['user_id'];
    bookingId = json["booking_id"];
    message = json["message"];
    eventName = json["eventName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['created_on'] = createdOn;
    data['slots_booked'] = slotsBooked;
    data['total_price'] = totalPrice;
    data['tour_id'] = tourId;
    data['user_id'] = userId;
    data["booking_id"] = bookingId;
    data["message"] = message;
    return data;
  }
}
