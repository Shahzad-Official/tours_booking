import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/utils/date_utils.dart/format_date.dart';
import 'package:tours_booking/views/registeration/login.dart';
import 'package:tours_booking/views/review/review.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../constants/app_colors.dart';
import '../../utils/date_utils.dart/calculate_days.dart';

class Timer extends StatelessWidget {
  final PackagesModel packageData;
  const Timer({
    super.key,
    required this.packageData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [
              const Color(0xff00a3ff).withOpacity(0.05),
              const Color(0xff0094ff).withOpacity(0.19),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: AppPadding.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppText(
                      overflow: TextOverflow.ellipsis,
                      text: packageData.packageName.toString(),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      textcolor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 85,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Image.asset("assets/logo.png"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText(
                  text: "Bookings Remaining: ${packageData.availablePackages}",
                  textcolor: const Color(0xff8E88A9),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            AppText(
                text: "Start Date & Time: ${FormatDate.formatedDate(
              formatPattern: "dd/MM/yyyy",
              date: packageData.startDate.toString(),
            )} | ${packageData.startTime}"),
            const SizedBox(
              height: 5,
            ),
            AppText(
                text: "End Date & Time:   ${FormatDate.formatedDate(
              formatPattern: "dd/MM/yyyy",
              date: packageData.endDate.toString(),
            )} | ${packageData.endTime}"),
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
                    const AppText(
                      text: "Package Price",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    AppText(
                      text: "\$${packageData.startPrice}",
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
                              text:
                                  "${CalculateDays.dateDiffrence(startDate: packageData.startDate!, endDate: packageData.endDate!).day}D",
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
                              text:
                                  "${CalculateDays.dateDiffrence(startDate: packageData.startDate!, endDate: packageData.endDate!).hour}H",
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
                              text:
                                  "${CalculateDays.dateDiffrence(startDate: packageData.startDate!, endDate: packageData.endDate!).second}S",
                              textcolor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AppText(
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
                const AppText(
                  text: "Travel & Tours inc",
                  textcolor: Color(0xff302A4E),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                Column(
                  children: [
                    const AppText(
                      text: "4.0",
                      textcolor: Color(0x2F2A4EA1),
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
              text: packageData.description.toString(),
              textcolor: const Color(0xffB6B6B6),
              fontSize: 12,
            ),
            const SizedBox(
              height: 30,
            ),
            AppButton(
              btnText: "GO NOW",
              ontap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                if (preferences.getBool("isLogedIn") == null) {
                  Get.off(
                    () => const Login(),
                  );
                } else if (preferences.getBool("isLogedIn")!) {
                  Get.to(
                    () => ReviewPage(
                      packageData: packageData,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
