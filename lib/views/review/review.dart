import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/models/user_profile/profile_model.dart';
import 'package:tours_booking/services/get_user_data.dart';
import 'package:tours_booking/services/reviews_services.dart';
import 'package:tours_booking/utils/date_utils.dart/format_date.dart';
import 'package:tours_booking/views/checkout/checkout.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_text.dart';

class ReviewPage extends StatefulWidget {
  final PackagesModel packageData;
  const ReviewPage({
    super.key,
    required this.packageData,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool? isLogedIn;
  Box box = Hive.box("DataBox");
  ProfileModel userData = ProfileModel();
  ReviewsServices reviewsServices = ReviewsServices();
  GetUserData getUserData = GetUserData();
  bool isLoading = false;
  checkLogin() async {
    userData = ProfileModel.fromJson(box.get("userData"));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLogedIn = preferences.getBool("isLogedIn");
    setState(() {
      isLoading = true;
    });
    await reviewsServices.getAllReviews(
      widget.packageData.packageId!,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            right: 10,
          ),
          child: AppBar(
            leading: const BackButton(
              color: Colors.black,
            ),
            elevation: 0.0,
            backgroundColor: AppColors.backgroundcolor,
            title: const AppText(
              text: "Reviews",
              fontWeight: FontWeight.w600,
              fontSize: 23,
              textcolor: Colors.black,
            ),
            actions: [
              AppCircularCachedImage(
                picUrl: userData.profile!,
                picRadius: 25,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: AppPadding.defaultPadding,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: List.generate(
                                reviewsServices.allReviews.length, (index) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FutureBuilder<ProfileModel>(
                                                future: getUserData.getUserData(
                                                    reviewsServices
                                                        .allReviews[index]
                                                        .userId!),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Row(
                                                      children: [
                                                        AppCircularCachedImage(
                                                          picRadius: 25,
                                                          picUrl: snapshot
                                                              .data!.profile!,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AppText(
                                                              text: snapshot
                                                                  .data!
                                                                  .userName
                                                                  .toString(),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            AppText(
                                                              text: FormatDate
                                                                  .formatedDate(
                                                                formatPattern:
                                                                    "hh:mm a , dd MMM yyyy",
                                                                date: reviewsServices
                                                                    .allReviews[
                                                                        index]
                                                                    .createdOn!,
                                                              ),
                                                              fontSize: 11,
                                                              textcolor:
                                                                  const Color(
                                                                      0xff999999),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                }),
                                            RatingBar.builder(
                                              initialRating: reviewsServices
                                                  .allReviews[index].rating!,
                                              glowRadius: 1,
                                              itemSize: 18,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              ignoreGestures: true,
                                              itemCount: 5,
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (value) {},
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: AppText(
                                            text: reviewsServices
                                                .allReviews[index].feedBack
                                                .toString(),
                                            textcolor: const Color(0xff999999),
                                          ),
                                        ),
                                        AppPadding.heightSpace20,
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceEvenly,
                                        //   children: [
                                        //     Container(
                                        //       height: 70,
                                        //       decoration: BoxDecoration(
                                        //           borderRadius:
                                        //               BorderRadius.circular(22)),
                                        //       child: Image(
                                        //           height: 70,
                                        //           width: MediaQuery.of(context)
                                        //                   .size
                                        //                   .width *
                                        //               0.26,
                                        //           image: const NetworkImage(
                                        //               "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60")),
                                        //     ),
                                        //     Container(
                                        //       height: 70,
                                        //       decoration: BoxDecoration(
                                        //           borderRadius:
                                        //               BorderRadius.circular(22)),
                                        //       child: Image(
                                        //           height: 50,
                                        //           width: MediaQuery.of(context)
                                        //                   .size
                                        //                   .width *
                                        //               0.26,
                                        //           image: const NetworkImage(
                                        //               "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60")),
                                        //     ),
                                        //     Container(
                                        //       height: 70,
                                        //       decoration: BoxDecoration(
                                        //           borderRadius:
                                        //               BorderRadius.circular(22)),
                                        //       child: Image(
                                        //           height: 50,
                                        //           width: MediaQuery.of(context)
                                        //                   .size
                                        //                   .width *
                                        //               0.26,
                                        //           image: const NetworkImage(
                                        //               "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60")),
                                        //     )
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                    width: double.infinity,
                                    child: Container(
                                      color: const Color(0xffE0E0E0),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                  AppPadding.heightSpace30,
                  AppPadding.heightSpace30,
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                btnText: "Book Now",
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const AppText(
                        text: "Terms and Condition!",
                        textcolor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      content: Container(
                        height: 30,
                      ),
                      actions: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AppText(
                            text: "I have agreed to the terms and conditions",
                            textcolor: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppButton(
                            btnText: "Agree",
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Checkout(
                                    packageData: widget.packageData,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
