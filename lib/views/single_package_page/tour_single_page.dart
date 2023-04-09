import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/utils/danger_rating_data.dart';
import 'package:tours_booking/utils/date_utils.dart/calculate_days.dart';
import 'package:tours_booking/utils/date_utils.dart/format_date.dart';
import 'package:tours_booking/views/timer/timer.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'package:tours_booking/widgets/app_text.dart';

class PackageSinglePage extends StatelessWidget {
  final PackagesModel packageData;
  const PackageSinglePage({
    Key? key,
    required this.packageData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 420,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: AppColors.primarycolor.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 420,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: AppColors.primarycolor.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: AppCachedImage(
                        picUrl: packageData.thumbnailUrl.toString(),
                      ),
                    ),
                    Padding(
                      padding: AppPadding.defaultPadding,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 65,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(1, 2),
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.7),
                                        Colors.white.withOpacity(0.11),
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.share,
                                color: Colors.blueAccent,
                                size: 35,
                              )
                            ],
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Container(
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.6),
                                  Colors.white.withOpacity(0.11),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(1, 2),
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  packageData.otherImage!.length,
                                  (index) => AppCachedImage(
                                    picUrl: packageData.otherImage![index]
                                        .toString(),
                                    height: 70,
                                    width: 70,
                                    child: packageData.otherImage!.length > 4
                                        ? Center(
                                            child: AppText(
                                              text:
                                                  "+ ${packageData.otherImage!.length - 4}",
                                              fontSize: 18,
                                              textcolor: Colors.white,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: AppPadding.defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: packageData.packageName,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: " 8.9",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueAccent,
                              ),
                            ),
                            TextSpan(
                              text: "/10",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    AppText(
                      text: packageData.location!.address.toString(),
                      textcolor: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: "Start Date & Time",
                              fontSize: 12,
                            ),
                            AppText(
                              text: "${FormatDate.formatedDate(
                                formatPattern: "dd/MM/yyyy",
                                date: packageData.startDate.toString(),
                              )} | ${packageData.startTime}",
                              fontSize: 10,
                              textcolor: Colors.blueAccent,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: "Duration",
                              fontSize: 12,
                            ),
                            AppText(
                              text: "${FormatDate.formatedDate(
                                formatPattern: "dd/MM/yyyy",
                                date: packageData.endDate.toString(),
                              )} | 1+ hour",
                              fontSize: 10,
                              textcolor: Colors.blueAccent,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.star_border),
                            AppText(
                              text: DangerRatingData.danger(
                                packageData.dangerRating.toString(),
                              ),
                              fontSize: 10,
                              textcolor: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          text: "Age Suitability ",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textcolor: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: AppText(
                            text: packageData.ageSuitability.toString(),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textcolor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Myslider(
                      value: int.parse(packageData.ageSuitability!),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: "Category",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textcolor: Colors.grey,
                            ),
                            AppText(
                              text: packageData.typeOfTour.toString(),
                              fontSize: 12,
                              textcolor: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Timer(
                        packageData: packageData,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 2),
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: CircularPercentIndicator(
                    reverse: true,
                    radius: 55,
                    percent: 0.40,
                    animationDuration: 1000,
                    animateFromLastPercent: true,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    lineWidth: 7,
                    backgroundColor: AppColors.headTextColor.withOpacity(0.5),
                    progressColor: AppColors.primarycolor,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: "\$${packageData.startPrice}",
                          fontWeight: FontWeight.w700,
                          textcolor: AppColors.primarycolor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primarycolor,
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                  color:
                                      AppColors.primarycolor.withOpacity(0.1),
                                ),
                                child: Center(
                                  child: AppText(
                                    text:
                                        "${CalculateDays.dateDiffrence(startDate: packageData.startDate!, endDate: packageData.endDate!).day}D",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    textcolor: Colors.blue,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primarycolor,
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                  color:
                                      AppColors.primarycolor.withOpacity(0.1),
                                ),
                                child: Center(
                                  child: AppText(
                                    text:
                                        "${CalculateDays.dateDiffrence(startDate: packageData.startDate!, endDate: packageData.endDate!).hour}H",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    textcolor: Colors.blue,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primarycolor,
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                  color:
                                      AppColors.primarycolor.withOpacity(0.1),
                                ),
                                child: Center(
                                  child: AppText(
                                    text:
                                        "${CalculateDays.dateDiffrence(startDate: packageData.startDate!, endDate: packageData.endDate!).minute}M",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    textcolor: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Myslider extends StatelessWidget {
  final int value;
  const Myslider({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.max,
            children: [
          Expanded(
              child: Slider(
                  thumbColor: Colors.white,
                  value: value.toDouble(),
                  min: 1.0,
                  max: 20.0,
                  divisions: 15,
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.black45,
                  label: 'Age',
                  onChanged: (double newValue) {},
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  })),
        ]));
  }
}
