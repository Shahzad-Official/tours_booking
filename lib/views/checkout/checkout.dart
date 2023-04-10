import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/utils/date_utils.dart/format_date.dart';
import 'package:tours_booking/views/checkout/credit_card.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../constants/app_colors.dart';
import '../../models/user_profile/profile_model.dart';

class Checkout extends StatefulWidget {
  final PackagesModel packageData;
  const Checkout({
    super.key,
    required this.packageData,
  });

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  ProfileModel userData = ProfileModel();
  getUserData() {
    Box box = Hive.box("DataBox");
    userData = ProfileModel.fromJson(box.get("userData"));
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.backgroundcolor,
            leading: const BackButton(
              color: Colors.black,
            ),
            title: const AppText(
              text: "Checkout",
              fontWeight: FontWeight.w600,
              fontSize: 23,
              textcolor: Colors.black,
            ),
            actions: [
              AppCircularCachedImage(
                picUrl: userData.profile!,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: AppPadding.defaultPadding,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 150,
                  child: AppCachedImage(
                    borderRadius: 10,
                    picUrl: widget.packageData.thumbnailUrl.toString(),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: widget.packageData.packageName!,
                      textcolor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: AppText(
                        text: widget.packageData.location!.address!,
                        textcolor: const Color(0xff161618),
                        fontSize: 8,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff3FAFFF),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppText(
                        text: FormatDate.formatedDate(
                          formatPattern: "E dd MMM yyyy",
                          date: widget.packageData.endDate!,
                        ),
                        textcolor: const Color(0xff3FAFFF),
                        fontSize: 10,
                      ),
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Color(0xff3FAFFF),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff3FAFFF),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppText(
                        text: widget.packageData.endTime!,
                        textcolor: const Color(0xff3FAFFF),
                        fontSize: 10,
                      ),
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Color(0xff3FAFFF),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                AppText(
                  text: "Payment Summary",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    AppText(text: "Subtotal"),
                    SizedBox(
                      height: 5,
                    ),
                    AppText(text: "Discount Total"),
                    SizedBox(
                      height: 5,
                    ),
                    AppText(
                      text: "Total Payment",
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: " \$${widget.packageData.startPrice!}"),
                    const SizedBox(
                      height: 5,
                    ),
                    AppText(
                        text:
                            "-\$${(int.parse(widget.packageData.startPrice!) - (int.parse(widget.packageData.endPrice!)))}"),
                    const SizedBox(
                      height: 5,
                    ),
                    AppText(
                      text: " \$${widget.packageData.endPrice!}",
                      fontWeight: FontWeight.w600,
                      textcolor: const Color(0xffFFBC4F),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            AppButton(
              btnText: "Proceed",
              ontap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreditCard(
                      packageData: widget.packageData,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
