import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/views/checkout/checkout.dart';
import 'package:tours_booking/views/registeration/login.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_text.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool? isLogedIn;

  checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLogedIn = preferences.getBool("isLogedIn");
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
            elevation: 0.0,
            backgroundColor: AppColors.backgroundcolor,
            title: AppText(
              text: "Reviews",
              fontWeight: FontWeight.w600,
              fontSize: 23,
              textcolor: Colors.black,
            ),
            actions: [
              AppCircularCachedImage(
                picUrl: DummyData.profilePic,
                picRadius: 25,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: AppPadding.defaultPadding,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: List.generate(3, (index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600"))),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text: "Patrick Adeleke",
                                              fontWeight: FontWeight.w600,
                                            ),
                                            AppText(
                                              text: "10:00 AM, 20 Oct 2022",
                                              fontSize: 11,
                                              textcolor:
                                                  const Color(0xff999999),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
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
                                      onRatingUpdate: (rating) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: AppText(
                                              text: "Give Review",
                                              textcolor: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            content: SizedBox(
                                              height: 165,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RatingBar.builder(
                                                      initialRating: 0,
                                                      glowRadius: 1,
                                                      itemSize: 27,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemPadding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      itemCount: 5,
                                                      itemBuilder: (context,
                                                              _) =>
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      }),
                                                  AppText(text: "Feedback"),
                                                  TextFormField(
                                                    maxLines: 3,
                                                    decoration: InputDecoration(
                                                      fillColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              224,
                                                              239,
                                                              252),
                                                      filled: true,
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              SizedBox(
                                                width: double.infinity,
                                                height: 45,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppColors
                                                                .primarycolor),
                                                  ),
                                                  child:
                                                      AppText(text: "Submit"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                AppText(
                                  text:
                                      "Very good the hotel is comfortable and also very affordable. the holiday atmosphere is also very supportive and hotel on the betaland.",
                                  textcolor: const Color(0xff999999),
                                ),
                                AppPadding.heightSpace20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      child: Image(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.26,
                                          image: const NetworkImage(
                                              "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60")),
                                    ),
                                    Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      child: Image(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.26,
                                          image: const NetworkImage(
                                              "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60")),
                                    ),
                                    Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      child: Image(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.26,
                                          image: const NetworkImage(
                                              "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60")),
                                    )
                                  ],
                                )
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
                  AppPadding.heightSpace30,
                  AppPadding.heightSpace30,
                ],
              ),
            ),
            AppButton(
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              btnText: "Book Now",
              ontap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: AppText(
                      text: "Terms and Condition!",
                      textcolor: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    content: Container(
                      height: 30,
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                  builder: (context) => const Checkout(),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
