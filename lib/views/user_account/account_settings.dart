import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/models/user_profile/profile_model.dart';
import 'package:tours_booking/services/get_user_data.dart';
import 'package:tours_booking/views/mybookinpage/mybooking_page.dart';
import 'package:tours_booking/views/user_account/profile.dart';
import 'package:tours_booking/views/user_account/terms_and_conditions.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';

import '../../widgets/app_text.dart';

class AccountSettings extends StatelessWidget {
  AccountSettings({super.key});
  final GetUserData _userData = GetUserData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.backgroundcolor,
        title: const AppText(
          text: "Account",
          fontWeight: FontWeight.w600,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: FutureBuilder<ProfileModel>(
          future: _userData.getUserData(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: AppPadding.defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AppCircularCachedImage(
                          picUrl:
                              snapshot.data!.profile ?? DummyData.profilePic,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: snapshot.data!.userName!,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              textcolor: const Color(0xff232332),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => UserProfile(
                                          userData: snapshot.data!,
                                        )),
                                  ),
                                );
                              },
                              child: const AppText(
                                text: "View my profile",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                textcolor: Color(0xff39ACFF),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const AppText(
                      text: "Settings",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      textcolor: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => UserProfile(
                                  userData: snapshot.data!,
                                )),
                          ),
                        );
                      },
                      leading: const AppText(
                        text: "Personal Information",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        textcolor: Color(0xff232332),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBookingPage(),
                          ),
                        );
                      },
                      leading: const AppText(
                        text: "My Bookings",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        textcolor: Color(0xff232332),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {},
                      leading: const AppText(
                        text: "Payments",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        textcolor: Color(0xff232332),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {},
                      leading: const AppText(
                        text: "Notifications",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        textcolor: Color(0xff232332),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsandConditionPage(),
                          ),
                        );
                      },
                      leading: const AppText(
                        text: "Terms  &  Conditions",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        textcolor: Color(0xff232332),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
