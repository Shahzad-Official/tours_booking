import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/svg_icons.dart';
import 'package:tours_booking/controllers/credit_card_controller/credit_card_controller.dart';
import 'package:tours_booking/views/bookings/ongoing_bookings.dart';
import 'package:tours_booking/views/main_page/main_page.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_input_field.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  String selectedDateCredit = '';

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundcolor,
        elevation: 0.0,
      ),
      body: Container(
        padding: AppPadding.defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "Credit Card Information",
                textcolor: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              AppText(
                text: "Card Information",
                textcolor: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "0000  0000  0000",
                    hintStyle: GoogleFonts.poppins(),
                    suffix: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: SvgPicture.string(SvgIcons.mastercard),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.only(top: 5, left: 10, right: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Expiry Date",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        textcolor: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<CreditCardController>(
                        init: CreditCardController(),
                        initState: (_) {},
                        builder: (_) {
                          return InkWell(
                            onTap: () {
                              _.selectDate(context);
                            },
                            child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              child: Center(
                                child: AppText(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  text: _.date ?? "MM/YY",
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Security Code",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        textcolor: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: "CVC",
                            contentPadding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            hintStyle: GoogleFonts.poppins(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppText(
                text: "Name on Card",
                textcolor: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: GoogleFonts.poppins(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.only(top: 5, left: 10, right: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      value: value,
                      checkColor: Colors.white,
                      activeColor: AppColors.primarycolor,
                      onChanged: (val) {
                        setState(() {
                          value = val!;
                        });
                      },
                    ),
                  ),
                  AppText(
                    text: "Save information for future use",
                    textcolor: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: AppText(
                        text: "Success!",
                        textcolor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      content: AppText(
                        text: "Booking confirmed; Invoice sent via mail.",
                      ),
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primarycolor),
                          ),
                          child: AppText(text: "OK"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(
                                    currentIndex: 2,
                                  ),
                                ));
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.primarycolor),
                  child: Center(
                    child: AppText(
                      text: "Pay",
                      textcolor: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: const Color(0xff111111)),
                  child: Center(
                    child: AppText(
                      text: "Cancel",
                      textcolor: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
