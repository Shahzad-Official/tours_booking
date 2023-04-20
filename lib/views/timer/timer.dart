import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/controllers/timer_page_controller.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/utils/date_utils.dart/format_date.dart';
import 'package:tours_booking/views/registeration/login.dart';
import 'package:tours_booking/views/review/review.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../constants/app_colors.dart';

class Timer extends StatefulWidget {
  final PackagesModel packageData;
  const Timer({
    super.key,
    required this.packageData,
  });

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  TimerController controller = Get.put(TimerController());
  @override
  void initState() {
    controller.startTimer(timestamp: widget.packageData.endDate!);
    super.initState();
  }

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
        child: GetBuilder<TimerController>(
            init: TimerController(),
            builder: (_) {
              if (_.time == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                overflow: TextOverflow.ellipsis,
                                text: widget.packageData.packageName.toString(),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                textcolor: Colors.black,
                              ),
                              AppText(
                                overflow: TextOverflow.ellipsis,
                                text: "${widget.packageData.location!.address}",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                textcolor: Colors.black,
                              ),
                            ],
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
                  AppPadding.heightSpace20,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Packages Remaining : ",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "${widget.packageData.availablePackages}",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primarycolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Start Date & Time\n",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "${FormatDate.formatedDate(
                                formatPattern: "dd/MM/yyyy",
                                date: widget.packageData.startDate.toString(),
                              )} | ${widget.packageData.startTime}",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primarycolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "End Date & Time\n",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "${FormatDate.formatedDate(
                                formatPattern: "dd/MM/yyyy",
                                date: widget.packageData.endDate.toString(),
                              )} | ${widget.packageData.endTime}",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primarycolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CircularPercentIndicator(
                      circularStrokeCap: CircularStrokeCap.round,
                      radius: 110.0,
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
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          AppText(
                            text: "\$${widget.packageData.startPrice}",
                            textcolor: AppColors.primarycolor,
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                          ),
                        ],
                      ),
                      progressColor: _.time!.day == 1
                          ? AppColors.day1Color
                          : _.time!.day == 2
                              ? AppColors.day2Color
                              : AppColors.day3Color,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: AppText(
                      text: "Booking Cutoff time",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: Row(
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
                                  text: widget.packageData.cuttOffTime!
                                      .split(":")
                                      .first,
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
                                  text: widget.packageData.cuttOffTime!
                                      .split(":")
                                      .last,
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
                                ),
                              ),
                              child: Center(
                                child: AppText(
                                  text: "0 S",
                                  textcolor: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                            packageData: widget.packageData,
                          ),
                        );
                      }
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}
