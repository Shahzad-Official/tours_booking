import 'package:flutter/material.dart';
import 'package:tours_booking/utils/tool_tip_shap.dart';

class AppToolTip extends StatelessWidget {
  final String text;
  const AppToolTip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: true,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      // decoration: const ShapeDecoration(
      //   color: Colors.blue,
      //   // shape: TooltipShapeBorder(
      //   //   radius: 5,
      //   //   arrowWidth: 10,
      //   // ),
      // ),
      triggerMode: TooltipTriggerMode.tap,
      onTriggered: () {},
      message: text,
      child: const CircleAvatar(
        radius: 10,
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.question_mark_rounded,
          size: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
