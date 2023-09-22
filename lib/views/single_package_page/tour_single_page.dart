import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/services/reviews_services.dart';
import 'package:tours_booking/utils/date_utils.dart/calculate_days.dart';
import 'package:tours_booking/views/review/review.dart';
import 'package:tours_booking/views/timer/timer.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'package:tours_booking/widgets/app_text.dart';
import 'package:tours_booking/widgets/app_tool_tip.dart';

import '../../controllers/timer_page_controller.dart';

class PackageSinglePage extends StatefulWidget {
  final PackagesModel packageData;
  const PackageSinglePage({
    Key? key,
    required this.packageData,
  }) : super(key: key);

  @override
  State<PackageSinglePage> createState() => _PackageSinglePageState();
}

class _PackageSinglePageState extends State<PackageSinglePage> {
  CalculateDays calculateDays = CalculateDays();
  final ReviewsServices reviewsServices = ReviewsServices();
  TimerController controller = Get.put(TimerController());
  bool isLoading = false;
  double totalRating = 0.0;
  getData() async {
    setState(() {
      isLoading = true;
    });
    calculateDays.daysBetweenDates(
      endDate: widget.packageData.endDate.toString(),
      endTime: widget.packageData.endTime.toString(),
      startTime: widget.packageData.startTime.toString(),
    );
    await reviewsServices.getAllReviews(
      widget.packageData.packageId!,
    );
    if (reviewsServices.allReviews.isNotEmpty) {
      totalRating = reviewsServices.allReviews.fold(0.0, (previousValue, element) => previousValue + element.rating!);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();

    controller.startTimer(
      packageStartDateTime: widget.packageData.startDate!,
      packageEndDateTime: widget.packageData.endDate!,
      packageStartTime: widget.packageData.startTime!,
      packageEndTime: widget.packageData.endTime!,
      startPrice: widget.packageData.startPrice!,
      endPrice: widget.packageData.endPrice!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.47,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
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
                                height: MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  color: AppColors.primarycolor.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                ),
                                child: AppCachedImage(
                                  picUrl: widget.packageData.thumbnailUrl.toString(),
                                ),
                              ),
                              Padding(
                                padding: AppPadding.defaultPadding,
                                child: Column(
                                  children: [
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
                                    const Spacer(),
                                    Container(
                                      height: 90,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      decoration: widget.packageData.otherImage!.isEmpty
                                          ? null
                                          : BoxDecoration(
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
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Center(
                                          child: Wrap(
                                            spacing: 20,
                                            children: List.generate(
                                              widget.packageData.otherImage!.length,
                                              (index) => AppCachedImage(
                                                picUrl: widget.packageData.otherImage![index].toString(),
                                                height: 70,
                                                width: 70,
                                                borderRadius: 10,
                                              ),
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
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: AppPadding.defaultPadding,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: widget.packageData.packageName,
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " ${totalRating.toStringAsFixed(1)}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "/5",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                AppText(
                                  text: widget.packageData.location!.address.toString(),
                                  textcolor: Colors.grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GetBuilder<TimerController>(
                            init: TimerController(),
                            builder: (_) {
                              return Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                                        builder: (context) {
                                          return Timer(
                                            packageData: widget.packageData,
                                          );
                                        },
                                      );
                                    },
                                    child: _.time == null
                                        ? const CircularProgressIndicator()
                                        : Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
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
                                              percent: _.percent,
                                              animationDuration: 1000,
                                              animateFromLastPercent: true,
                                              animation: true,
                                              circularStrokeCap: CircularStrokeCap.round,
                                              lineWidth: 7,
                                              backgroundColor: AppColors.headTextColor.withOpacity(0.5),
                                              progressColor: calculateDays.days >= 3
                                                  ? AppColors.day3Color
                                                  : calculateDays.days == 2
                                                      ? AppColors.day2Color
                                                      : AppColors.day1Color,
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AppText(
                                                    text: "\$${_.remainingPrice}",
                                                    fontWeight: FontWeight.w700,
                                                    textcolor: AppColors.primarycolor,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: AppColors.primarycolor,
                                                              width: 0.5,
                                                            ),
                                                            borderRadius: BorderRadius.circular(
                                                              4,
                                                            ),
                                                            color: AppColors.primarycolor.withOpacity(0.1),
                                                          ),
                                                          child: Center(
                                                            child: AppText(
                                                              text: widget.packageData.cuttOffTime!.split(":").first,
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
                                                            border: Border.all(color: AppColors.primarycolor, width: 0.5),
                                                            borderRadius: BorderRadius.circular(4),
                                                            color: AppColors.primarycolor.withOpacity(0.1),
                                                          ),
                                                          child: Center(
                                                            child: AppText(
                                                              text: widget.packageData.cuttOffTime!.split(":").last,
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
                              );
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: AppPadding.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppPadding.heightSpace15,
                        AppText(
                          text: widget.packageData.description.toString(),
                          textcolor: Colors.grey,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppPadding.heightSpace20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GetBuilder<TimerController>(
                              init: TimerController(),
                              initState: (_) {},
                              builder: (_) {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Package Duration : ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: calculateDays.isHours
                                            ? "${calculateDays.hour} +hours"
                                            : calculateDays.days == 1
                                                ? "${calculateDays.days} /day"
                                                : "${calculateDays.days} /days",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primarycolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const AppText(
                              text: "Inclusions : ",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              textcolor: Colors.black,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      icon: const Align(
                                        alignment: Alignment.topRight,
                                        child: CloseButton(),
                                      ),
                                      title: const AppText(text: "Inclusions"),
                                      content: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: widget.packageData.inclusions!.length,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 0.7,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Container(
                                                color: AppColors.primarycolor.withOpacity(0.3),
                                                height: 70,
                                                width: 70,
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: AppCachedImage(
                                                        height: 50,
                                                        width: 50,
                                                        picUrl: widget.packageData.inclusions![index].iconImage.toString(),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.topRight,
                                                      child: CircleAvatar(
                                                        radius: 10,
                                                        child: Center(
                                                          child: AppText(
                                                            text: widget.packageData.inclusions![index].inclusionCount.toString(),
                                                            fontSize: 8,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Image.asset(
                                "assets/inclusions.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const AppText(
                              text: "Age Suitability : ",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              textcolor: Colors.black,
                            ),
                            AppText(
                              text: "${widget.packageData.ageSuitability.toString()} +",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              textcolor: AppColors.primarycolor,
                            ),
                          ],
                        ),
                        Slider(
                          min: 1,
                          max: 16,
                          value: double.parse(widget.packageData.ageSuitability.toString()),
                          onChanged: (value) {},
                        ),
                        AppPadding.heightSpace20,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Category : ",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.packageData.category.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primarycolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppPadding.heightSpace15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 8,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Danger Rating : ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.packageData.dangerRating == "1"
                                          ? "Easy Going"
                                          : widget.packageData.dangerRating == "2"
                                              ? "Excitement Guaranteed"
                                              : "Excitement Blast",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primarycolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: AppToolTip(
                                text: "Danger Rating hint",
                              ),
                            ),
                          ],
                        ),
                        AppPadding.heightSpace20,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Package Type : ",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: "${widget.packageData.typeOfTour}",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primarycolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "People per package : ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${widget.packageData.noOfPersonsInPackage} +",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primarycolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => ReviewPage(
                                    packageData: widget.packageData,
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  AppText(
                                    text: totalRating.toStringAsFixed(1),
                                    textcolor: const Color.fromARGB(183, 15, 20, 25),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                  RatingBar.builder(
                                    initialRating: totalRating,
                                    glowRadius: 1,
                                    itemSize: 20,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
