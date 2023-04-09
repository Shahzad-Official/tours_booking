import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/controllers/bookings_controllers/ongoing_bookings_controller.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';

import '../../constants/app_padding.dart';
import '../../widgets/app_text.dart';
import '../../widgets/bookinwidget/booking_widget.dart';

class OngoingBookings extends StatelessWidget {
  OngoingBookings({Key? key}) : super(key: key);
  final OngoingBookingsController bookingsController =
      Get.put(OngoingBookingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: AppPadding.defaultPadding,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "Ongoing \nBookings",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  AppCircularCachedImage(
                    picUrl: DummyData.profilePic,
                    picRadius: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: BookingWidget(),
    );
  }
}
