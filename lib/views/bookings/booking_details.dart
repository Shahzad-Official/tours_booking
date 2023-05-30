import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/svg_icons.dart';
import 'package:tours_booking/controllers/feedback_controller.dart';
import 'package:tours_booking/models/booking_model.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/models/user_profile/profile_model.dart';
import 'package:tours_booking/views/chat/chat_view.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'package:tours_booking/widgets/app_text.dart';
import '../../constants/app_colors.dart';
import '../../utils/date_utils.dart/format_date.dart';

class BookingDetails extends StatefulWidget {
  final PackagesModel packageData;
  final BookingModel bookingData;
  const BookingDetails({
    super.key,
    required this.packageData,
    required this.bookingData,
  });

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  ProfileModel userData = ProfileModel();
  Box box = Hive.box("DataBox");

  getUserData() {
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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          elevation: 0.0,
          backgroundColor: AppColors.backgroundcolor,
          title: const AppText(
            text: "Booking Details",
            fontWeight: FontWeight.w600,
            fontSize: 22,
            textcolor: Colors.black,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12, top: 3),
              child: AppCircularCachedImage(
                picUrl: userData.profile!,
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
                    picUrl: widget.packageData.thumbnailUrl!,
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
                    AppText(
                      text: widget.packageData.location!.address!,
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
            const Row(
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    AppText(
                      text: " \$${widget.packageData.startPrice!}",
                    ),
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
              btnText: "Give Feedback",
              ontap: () {
                showDialog(
                  context: context,
                  builder: (context) => GetBuilder<FeedbackController>(
                      init: FeedbackController(),
                      builder: (_) {
                        return AlertDialog(
                          title: const AppText(
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
                                  initialRating: _.currentRating,
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
                                  onRatingUpdate: (rating) {
                                    _.updateRating(rating);
                                  },
                                ),
                                const AppText(text: "Feedback"),
                                TextFormField(
                                  controller: _.feedBack,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    fillColor: const Color.fromARGB(
                                        255, 224, 239, 252),
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
                                child: _.isLoading
                                    ? const Center(
                                        child: SpinKitThreeBounce(
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )
                                    : const AppText(text: "Submit"),
                                onPressed: () async {
                                  await _.giveFeedBack(
                                    tourId: widget.packageData.packageId!,
                                  );
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              btnText: "Back",
              ontap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 160,
        child: FloatingActionButton(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            Get.to(
              () => ChatScreen(
                bookingId: widget.bookingData.bookingId!,
                receiverId: widget.packageData.listerId!,
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.string(
                SvgIcons.chat,
                height: 30,
                width: 30,
                // ignore: deprecated_member_use
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              const AppText(
                text: "Chat Now",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textcolor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
