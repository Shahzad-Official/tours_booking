import 'package:flutter/material.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/views/mybookinpage/mybooking_page.dart';
import 'package:tours_booking/views/user_account/profile.dart';
import 'package:tours_booking/views/user_account/terms_&_conditions.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';

import '../../widgets/app_text.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.backgroundcolor,
        title: AppText(
          text: "Account",
          fontWeight: FontWeight.w600,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: Container(
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
                  picUrl: DummyData.profilePic,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Pawan Kumar",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      textcolor: const Color(0xff232332),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const UserProfile(
                                  profileUrl: DummyData.profilePic,
                                )),
                          ),
                        );
                      },
                      child: AppText(
                        text: "View my profile",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        textcolor: const Color(0xff39ACFF),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            AppText(
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
              onTap: () {},
              leading: AppText(
                text: "Personal Information",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyBookingPage()));
              },
              leading: AppText(
                text: "My Bookings",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
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
              leading: AppText(
                text: "Payments",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
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
              leading: AppText(
                text: "Notifications",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
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
                        builder: (context) => TermsandConditionPage()));
              },
              leading: AppText(
                text: "Terms  &  Conditions",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
