import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';
import '../constants/svg_icons.dart';
import 'app_text.dart';

class AppBottomSheet extends StatelessWidget {
  final int currentIndex;
  final void Function(int index)? onIndexChanged;
  const AppBottomSheet({
    Key? key,
    this.currentIndex = 0,
    this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onIndexChanged,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  SvgIcons.home,
                  width: 30,
                  // ignore: deprecated_member_use
                  color: currentIndex == 0
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
                AppText(
                  text: "Home",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textcolor: currentIndex == 0
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  SvgIcons.plane,
                  width: 27,
                  // ignore: deprecated_member_use
                  color: currentIndex == 1
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
                AppText(
                  text: "All Packages",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textcolor: currentIndex == 1
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  SvgIcons.calender,
                  width: 25,
                  // ignore: deprecated_member_use
                  color: currentIndex == 2
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
                AppText(
                  text: "My Bookings",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textcolor: currentIndex == 2
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  SvgIcons.profile,
                  width: 22,
                  // ignore: deprecated_member_use
                  color: currentIndex == 3
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
                AppText(
                  text: "Profile",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textcolor: currentIndex == 3
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
              ],
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
