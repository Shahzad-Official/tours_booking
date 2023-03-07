import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/views/timer/timer.dart';
import 'package:tours_booking/widgets/app_text.dart';

class PackageSinglePage extends StatelessWidget {
  const PackageSinglePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/image2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
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
                              offset: Offset(1, 2),
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage("assets/image1.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage("assets/image1.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage("assets/image1.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage("assets/image1.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Center(
                                  child: AppText(
                                    text: "+5",
                                    fontSize: 18,
                                    textcolor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
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
                              text: "Pantai Dreamland ",
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
                      text: "Paris",
                      textcolor: Colors.grey,
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
                            AppText(
                              text: "Start Date & Time",
                              fontSize: 12,
                            ),
                            AppText(
                              text: "17/09/22 | 23:04",
                              fontSize: 10,
                              textcolor: Colors.blueAccent,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Duration",
                              fontSize: 12,
                            ),
                            AppText(
                              text: "17/09/22 | 1+ hour",
                              fontSize: 10,
                              textcolor: Colors.blueAccent,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.star_border),
                            AppText(
                              text: "Easy going",
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
                        AppText(
                          text: "Age Suitability ",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textcolor: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: AppText(
                            text: "+3",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textcolor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const myslider(),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Category",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textcolor: Colors.grey,
                            ),
                            AppText(
                              text: "Adventure",
                              fontSize: 12,
                              textcolor: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Tags",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textcolor: Colors.grey,
                            ),
                            AppText(
                              text: "Skiing",
                              fontSize: 12,
                              textcolor: Colors.black,
                            ),
                          ],
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
                      builder: (context) => Timer(),
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
                          text: "\$29.99",
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
                                    text: "2D",
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
                                    text: "9H",
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
                                    text: "7M",
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

class myslider extends StatefulWidget {
  const myslider({Key? key}) : super(key: key);

  @override
  State<myslider> createState() => _mysliderState();
}

class _mysliderState extends State<myslider> {
  int _value = 6;
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
                  value: _value.toDouble(),
                  min: 1.0,
                  max: 20.0,
                  divisions: 15,
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.black45,
                  label: 'count',
                  onChanged: (double newValue) {
                    setState(() {
                      _value = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  })),
        ]));
  }
}
