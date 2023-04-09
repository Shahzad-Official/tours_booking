import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/views/review/review.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'package:tours_booking/widgets/app_text.dart';
import '../../constants/app_colors.dart';

class BookingDetails extends StatelessWidget {
  BookingDetails({
    super.key,
  });
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.backgroundcolor,
          title: AppText(
            text: "Booking Details",
            fontWeight: FontWeight.w600,
            fontSize: 22,
            textcolor: Colors.black,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12, top: 3),
              child: AppCircularCachedImage(
                picUrl: DummyData.profilePic,
              ),
            ),
          ],
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
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.22,
                  child: AppCachedImage(
                    picUrl: DummyData.profilePic,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "eventName",
                      textcolor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    AppText(
                      text: "Jl. Lorem Ipsum Dolor Sit Amet Bandung No. 123",
                      textcolor: const Color(0xff161618),
                      fontSize: 8,
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
                      border: Border.all(color: const Color(0xff3FAFFF))),
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
                      border: Border.all(color: const Color(0xff3FAFFF))),
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
                    AppText(
                      text: "\$" + DummyData.eventsData[0]['startPrice'],
                    ),
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
                btnText: "Give Feedback",
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: AppText(
                        text: "Give Review",
                        textcolor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      content: SizedBox(
                        height: 165,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                                initialRating: 0,
                                glowRadius: 1,
                                itemSize: 27,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemPadding: const EdgeInsets.all(8),
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {}),
                            const AppText(text: "Feedback"),
                            TextFormField(
                              controller: reviewController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 224, 239, 252),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.primarycolor),
                            ),
                            child: AppText(text: "Submit"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ReviewPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            AppButton(
                btnText: "Back",
                ontap: () {
                  Navigator.pop(context);
                }),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
