import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_padding.dart';
import '../../constants/dummy_data.dart';
import '../../constants/svg_icons.dart';
import '../app_cache_image.dart';
import '../app_text.dart';

class SingleTourContainer extends StatelessWidget {
  final String? picUrl;
  final String startDate, endDate, eventName, location;

  final Widget ratingBar, bottomButton;
  const SingleTourContainer({
    Key? key,
    this.picUrl,
    this.endDate = "2nd",
    this.startDate = "2nd",
    this.eventName = "Event Culture",
    this.location = "Paris, Europe",
    required this.ratingBar,
    required this.bottomButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.backgroundcolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarycolor.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 1.5,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 110,
              decoration: BoxDecoration(
                color: AppColors.primarycolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: AppCachedImage(
                picUrl: picUrl ?? DummyData.profilePic,
              ),
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(
                        text: eventName,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ],
                  ),
                  AppText(
                    text: "$startDate - $endDate",
                    fontWeight: FontWeight.w600,
                    textcolor: AppColors.headTextColor,
                    fontSize: 12,
                  ),
                  AppPadding.heightSpace5,
                  Row(
                    children: [
                      SvgPicture.string(
                        SvgIcons.mapMarker,
                        width: 15,
                        color: AppColors.headTextColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: AppText(
                          overflow: TextOverflow.ellipsis,
                          text: location,
                          fontWeight: FontWeight.w600,
                          textcolor: AppColors.headTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  ratingBar,
                  AppPadding.heightSpace10,
                  bottomButton,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
