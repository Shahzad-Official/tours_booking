import 'package:flutter/material.dart';

import '../constants/app_padding.dart';
import 'app_button.dart';
import 'app_text.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.defaultPadding,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AppText(
                    text: "Best Match",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AppText(
                    text: "Nearest",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: AppText(
                    text: "Low Budget",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              AppText(
                text: "Category",
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
            children: [
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AppText(
                    text: "Indoor",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AppText(
                    text: "Outdoor",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: AppText(
                    text: "Mix",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
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
                text: "8km",
                fontSize: 10,
              ),
              AppText(
                text: "20km",
                fontSize: 10,
              ),
            ],
          ),
          DistanceSlider(),
          Row(
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
                text: "\$80",
                fontSize: 10,
              ),
              AppText(
                text: "\$300",
                fontSize: 10,
              ),
            ],
          ),
          DistanceSlider(),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              AppText(
                text: "Rating",
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
            children: [
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AppText(
                    text: "Indoor",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AppText(
                    text: "Outdoor",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: AppText(
                    text: "Mix",
                    fontSize: 12,
                    textcolor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(),
          ),
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
