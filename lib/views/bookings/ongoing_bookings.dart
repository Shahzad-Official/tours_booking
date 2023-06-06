import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tours_booking/controllers/bookings_controllers/ongoing_bookings_controller.dart';

import '../../constants/app_padding.dart';
import '../../models/user_profile/profile_model.dart';
import '../../widgets/app_text.dart';
import '../../widgets/bookinwidget/booking_widget.dart';

class OngoingBookings extends StatefulWidget {
  const OngoingBookings({Key? key}) : super(key: key);

  @override
  State<OngoingBookings> createState() => _OngoingBookingsState();
}

class _OngoingBookingsState extends State<OngoingBookings> {
  final OngoingBookingsController bookingsController = Get.put(OngoingBookingsController());
  ProfileModel userData = ProfileModel();
  getUserData() {
    Box box = Hive.box("DataBox");
    userData = ProfileModel.fromJson(box.get("userData"));
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Padding(
          padding: AppPadding.defaultPadding,
          child: Column(
            children: [
              SizedBox(
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
