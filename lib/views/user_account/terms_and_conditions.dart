import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tours_booking/services/get_user_data.dart';
import '../../constants/app_colors.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_text.dart';

class TermsandConditionPage extends StatelessWidget {
  TermsandConditionPage({super.key});
  final GetUserData _data = GetUserData();

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
          text: "Terms & Conditions",
          fontWeight: FontWeight.w500,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: FutureBuilder<String>(
        future: _data.getUserTermsAndConditions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: HtmlWidget(
                snapshot.data!,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
