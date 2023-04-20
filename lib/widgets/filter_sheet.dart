import 'package:flutter/material.dart';
import 'package:tours_booking/constants/app_colors.dart';

import '../constants/app_padding.dart';
import 'app_button.dart';
import 'app_text.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  List<String> types = [
    "Individual",
    "Couple",
    "Family/Group",
  ];
  List<String> rating = [
    "Easy going",
    "Excitement guaranteed",
    "Excitement Blast",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: const [
              AppText(
                text: "Sort by",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              AppText(
                text: "Type",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              types.length,
              (index) => Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primarycolor,
                  ),
                  color: AppColors.primarycolor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AppText(
                    text: types[index],
                    fontSize: 12,
                    textcolor: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: const [
              AppText(
                text: "Distance",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AppText(
                text: "8km",
                fontSize: 10,
              ),
              AppText(
                text: "20km",
                fontSize: 10,
              ),
            ],
          ),
          const DistanceSlider(),
          Row(
            children: const [
              AppText(
                text: "Budget",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AppText(
                text: "\$80",
                fontSize: 10,
              ),
              AppText(
                text: "\$300",
                fontSize: 10,
              ),
            ],
          ),
          const DistanceSlider(),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: const [
              AppText(
                text: "Danger Rating",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              rating.length,
              (index) => Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.star_outline_rounded,
                      size: 28,
                    ),
                    AppPadding.heightSpace5,
                    AppText(
                      text: rating[index],
                      fontSize: 12,
                      textcolor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppPadding.heightSpace15,
          const AppText(text: "Days to go :"),
          Center(
            child: Wrap(
              spacing: 20,
              children: List.generate(
                3,
                (index) => Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? AppColors.day1Color
                        : index == 1
                            ? AppColors.day2Color
                            : AppColors.day3Color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 2),
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: AppText(
                      textAlign: TextAlign.center,
                      text: "${index + 1} days",
                      fontSize: 8,
                      textcolor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          AppButton(btnText: "APPLY", ontap: () {}),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class DistanceSlider extends StatefulWidget {
  const DistanceSlider({Key? key}) : super(key: key);

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  RangeValues _currentRangeValues = const RangeValues(12, 16);
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      max: 20,
      min: 8,
      divisions: 10,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }
}
