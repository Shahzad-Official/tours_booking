import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/controllers/filter_sheet_controller.dart';

import '../constants/app_padding.dart';
import 'app_button.dart';
import 'app_text.dart';

class FilterSheet extends StatefulWidget {
  final VoidCallback onTap;
  const FilterSheet({
    Key? key,
    required this.onTap,
  }) : super(key: key);

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
      child: GetBuilder<FilterSheetController>(
        init: FilterSheetController(),
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
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
              const Row(
                children: [
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
                  (index) => InkWell(
                    onTap: () {
                      _.changeType(index, types[index]);
                    },
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width * .25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _.currentTypeIndex != index ? Colors.grey : AppColors.primarycolor,
                        ),
                        color: _.currentTypeIndex != index ? Colors.grey.withOpacity(0.1) : AppColors.primarycolor.withOpacity(0.1),
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
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
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
                children: [
                  AppText(
                    text: "${_.rangeValues.start.round()}km",
                    fontSize: 10,
                  ),
                  AppText(
                    text: "${_.rangeValues.end.round()}km",
                    fontSize: 10,
                  ),
                ],
              ),
              RangeSlider(
                values: _.rangeValues,
                max: 100,
                min: 0,
                divisions: 10,
                labels: RangeLabels(
                  _.rangeValues.start.round().toString(),
                  _.rangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  _.changeValues(values);
                },
              ),
              const Row(
                children: [
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
                children: [
                  AppText(
                    text: "\$${_.rangePriceValues.start.round()}",
                    fontSize: 10,
                  ),
                  AppText(
                    text: "\$${_.rangePriceValues.end.round()}",
                    fontSize: 10,
                  ),
                ],
              ),
              RangeSlider(
                values: _.rangePriceValues,
                max: 1500,
                min: 0,
                divisions: 10,
                labels: RangeLabels(
                  _.rangePriceValues.start.round().toString(),
                  _.rangePriceValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  _.changePriceValues(values);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
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
                        InkWell(
                          onTap: () {
                            _.changeRisk(index);
                          },
                          child: Icon(
                            _.currentRiskIndex == index ? Icons.star_rounded : Icons.star_outline_rounded,
                            size: 28,
                          ),
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
              AppPadding.heightSpace10,
              Center(
                child: Wrap(
                  spacing: 20,
                  children: List.generate(
                    3,
                    (index) => InkWell(
                      onTap: () {
                        _.changeDays(index, index + 1);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          border: _.currentDaysIndex != index
                              ? null
                              : Border.all(
                                  color: AppColors.primarycolor,
                                  width: 3,
                                ),
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
              ),
              const Spacer(),
              AppButton(
                btnText: "APPLY",
                ontap: widget.onTap,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
