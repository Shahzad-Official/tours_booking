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
          itemSize: 20,
          initialRating: initialRating ?? 2.1,
          allowHalfRating: true,
          itemCount: 4,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star_rate_rounded,
              color: AppColors.primarycolor,
            ),
            half: const Icon(
              Icons.star_half_rounded,
              color: AppColors.primarycolor,
            ),
            empty: const Icon(
              Icons.star_border_rounded,
              color: AppColors.primarycolor,
            ),
          ),
          onRatingUpdate: (double value) {},
        ),
      ],
    );
  }
}
