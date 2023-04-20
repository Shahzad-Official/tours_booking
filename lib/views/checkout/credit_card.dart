import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/svg_icons.dart';
import 'package:tours_booking/controllers/credit_card_controller/credit_card_controller.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../constants/app_colors.dart';
import '../../utils/card_formatter.dart';

class CreditCard extends StatefulWidget {
  final PackagesModel packageData;
  const CreditCard({
    super.key,
    required this.packageData,
  });

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  String selectedDateCredit = '';

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundcolor,
        elevation: 0.0,
      ),
      body: Container(
        padding: AppPadding.defaultPadding,
        child: GetBuilder<CreditCardController>(
            init: CreditCardController(),
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Credit Card Information",
                    textcolor: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const AppText(
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
                      maxLength: 19,
                      controller: _.cardNumber,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: "0000  0000  0000  0000",
                        hintStyle: GoogleFonts.poppins(),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: "Expiry Date",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              textcolor: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: _.expiryDate,
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                onTap: () {
                                  _.selectDate(context);
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: "XX/YYYY",
                                  hintStyle: GoogleFonts.poppins(),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10),
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
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
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
                                maxLength: 3,
                                controller: _.cvv,
                                keyboardType: TextInputType.number,
                                autofocus: false,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "CVV",
                                  contentPadding: const EdgeInsets.only(
                                    top: 5,
                                    left: 10,
                                    right: 10,
                                  ),
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
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AppText(
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
                      const AppText(
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
                    onTap: () async {
                      await _.makeBooking(
                        context,
                        bookedSlots: widget.packageData.noOfPersonsInPackage!
                            .split("-")
                            .last,
                        totalPrice: widget.packageData.endPrice!,
                        tourId: widget.packageData.packageId!,
                        eventName: widget.packageData.packageName!,
                        listerId: widget.packageData.listerId!,
                      );
                      // ignore: use_build_context_synchronously
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColors.primarycolor,
                      ),
                      child: Center(
                        child: _.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const AppText(
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
                      child: const Center(
                        child: AppText(
                          text: "Cancel",
                          textcolor: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
