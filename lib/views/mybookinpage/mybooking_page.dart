import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/svg_icons.dart';
import '../../controllers/bookings_controllers/ongoing_bookings_controller.dart';
import '../../widgets/app_text.dart';
import '../../widgets/bookinwidget/booking_widget.dart';

class MyBookingPage extends StatelessWidget {
  MyBookingPage({super.key});
  final OngoingBookingsController bookingsController =
      Get.put(OngoingBookingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.backgroundcolor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: SvgPicture.string(
              SvgIcons.backArrow,
            ),
          ),
        ),
        title: AppText(
          text: "My Bookings",
          fontWeight: FontWeight.w600,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookingWidget(
              bookingsController: bookingsController,
            ),
          ],
        ),
      ),
    );
  }
}
