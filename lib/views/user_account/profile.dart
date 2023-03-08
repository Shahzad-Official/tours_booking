import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tours_booking/models/user_profile/profile_model.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_padding.dart';
import '../../constants/dummy_data.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_cache_image.dart';
import '../../widgets/app_text.dart';
import 'edit_profile.dart';

class UserProfile extends StatelessWidget {
  final ProfileModel userData;
  const UserProfile({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.backgroundcolor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: SvgPicture.string(
              SvgIcons.backArrow,
            ),
          ),
        ),
        title: const AppText(
          text: "Profile",
          fontWeight: FontWeight.w600,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: AppPadding.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        text: "Hi! Pawan",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        textcolor: const Color(0xff232332),
                      ),
                      AppText(
                        text: "Joined - Mar 2021",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        textcolor: const Color(0xff8E89A9),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  AppCircularCachedImage(
                    picUrl: userData.profile.toString(),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const AppText(
                text: "Email",
                textcolor: AppColors.headTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              AppText(
                text: userData.email ?? DummyData.profileData['email'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace20,
              const AppText(
                text: "Phone Number",
                textcolor: AppColors.headTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              AppText(
                text: userData.phoneNo ?? DummyData.profileData['phoneNo'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace20,
              const AppText(
                text: "Date of Birth",
                textcolor: AppColors.headTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              AppText(
                text: userData.dob ?? DummyData.profileData['DOB'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace20,
              const SizedBox(
                height: 100,
              ),
              AppButton(
                btnText: "Edit",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => EditProfile()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
