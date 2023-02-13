import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_colors.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_text.dart';

class TermsandConditionPage extends StatelessWidget {
  const TermsandConditionPage({super.key});

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
        title: AppText(
          text: "Terms & Conditions",
          fontWeight: FontWeight.w500,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
    );
  }
}
