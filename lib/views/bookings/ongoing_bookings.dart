import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/controllers/bookings_controllers/ongoing_bookings_controller.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';

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
  final OngoingBookingsController bookingsController =
      Get.put(OngoingBookingsController());
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
                  const AppText(
                    text: "Ongoing \nBookings",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  AppCircularCachedImage(
                    picUrl: userData.profile == "" || userData.profile == null
                        ? DummyData.profilePic
                        : userData.profile!,
                    picRadius: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: const BookingWidget(),
    );
  }
}
