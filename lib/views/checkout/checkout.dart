import 'package:flutter/material.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/views/checkout/credit_card.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../constants/app_colors.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

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
            title: AppText(
              text: "Checkout",
              fontWeight: FontWeight.w600,
              fontSize: 23,
              textcolor: Colors.black,
            ),
            actions: [
              AppCircularCachedImage(
                picUrl: DummyData.profilePic,
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
                    picUrl: DummyData.eventsData[2]["coverImage"],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Pantai Dreamland",
                      textcolor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: AppText(
                        text: "Jl. Lorem Ipsum Dolor Sit Amet Bandung No. 123",
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
                        text: "Fri, 7 jan 2022",
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
                        text: "15.00 UTC",
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
              children: [
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
                  children: [
                    AppText(text: "Subtotal"),
                    const SizedBox(
                      height: 5,
                    ),
                    AppText(text: "Discount Total"),
                    const SizedBox(
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
                    AppText(text: " \$350"),
                    const SizedBox(
                      height: 5,
                    ),
                    AppText(text: "-\$100"),
                    const SizedBox(
                      height: 5,
                    ),
                    AppText(
                      text: " \$250",
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
                  MaterialPageRoute(builder: (context) => const CreditCard()),
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
