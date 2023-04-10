import 'package:get/get.dart';

import '../../models/booking_model.dart';

class OngoingBookingsController extends GetxController {
  List<BookingModel> allBookings = [];

  searchBooking({
    String query = "",
    required List<BookingModel> allBooking,
  }) {
    allBookings = allBooking
        .where(
          (element) => element.eventName!.toLowerCase().contains(
                query.trim().toLowerCase(),
              ),
        )
        .toList();
    update();
  }
}
