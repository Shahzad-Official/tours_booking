import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/views/review/review.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../constants/app_colors.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(colors: [
            const Color(0xff00a3ff).withOpacity(0.05),
            const Color(0xff0094ff).withOpacity(0.19),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        padding: AppPadding.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Paris",
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      textcolor: Colors.black,
                    ),
                    AppText(
                      text: "Pantai Dreamland",
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      textcolor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: 85,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset("assets/logo.png"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText(
                  text: "Bookings Remaining: 12",
                  textcolor: const Color(0xff8E88A9),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            AppText(text: "Start Date & Time: 17/09/2022 | 23:04"),
            const SizedBox(
              height: 5,
            ),
            AppText(text: "End Date & Time:   17/09/2022  | 23:04"),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                radius: 130.0,
                lineWidth: 10.0,
                percent: 0.3,
                animation: true,
                animationDuration: 1000,
                animateFromLastPercent: true,
                reverse: true,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: "Package Price",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    AppText(
                      text: "\$29.95",
                      textcolor: AppColors.primarycolor,
                      fontWeight: FontWeight.w800,
                      fontSize: 33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: AppColors.primarycolor,
                          )),
                          child: Center(
                            child: AppText(
                              text: "2D",
                              textcolor: Colors.blue,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: AppColors.primarycolor,
                          )),
                          child: Center(
                            child: AppText(
                              text: "9H",
                              textcolor: Colors.blue,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: AppColors.primarycolor,
                          )),
                          child: Center(
                            child: AppText(
                              text: "7M",
                              textcolor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: "Booking Cutoff time",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ],
                ),
                progressColor: AppColors.primarycolor,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "Travel & Tours inc",
                  textcolor: const Color(0xff302A4E),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                Column(
                  children: [
                    AppText(
                      text: "4.0",
                      textcolor: Color(0xff302A4EA1),
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    RatingBar.builder(
                        initialRating: 0,
                        glowRadius: 1,
                        itemSize: 18,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (rating) {}),
                  ],
                ),
              ],
            ),
            AppText(
              text:
                  "Dreamland beach there are white coral rocks that surround the beach, this creates a beautiful view of its own.",
              textcolor: const Color(0xffB6B6B6),
              fontSize: 12,
            ),
            const SizedBox(
              height: 30,
            ),
            AppButton(
              btnText: "GO NOW",
              ontap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
