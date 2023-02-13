import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_padding.dart';

class TourRatingBar extends StatelessWidget {
  final double? initialRating;
  const TourRatingBar({
    this.initialRating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPadding.heightSpace15,
        RatingBar(
          ignoreGestures: true,
          itemSize: 15,
          initialRating: initialRating ?? 2.1,
          allowHalfRating: true,
          itemCount: 4,
          ratingWidget: RatingWidget(
            full: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primarycolor,
              ),
            ),
            half: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primarycolor,
                  width: 0.5,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 10,
                    width: 5,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      color: AppColors.primarycolor,
                    ),
                  ),
                ],
              ),
            ),
            empty: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primarycolor,
                  width: 0.5,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          onRatingUpdate: (double value) {},
        ),
      ],
    );
  }
}
