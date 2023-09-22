import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tours_booking/controllers/bookings_controllers/ongoing_bookings_controller.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/services/booking_services.dart';
import 'package:tours_booking/services/package_services/get_all_packages.dart';
import 'package:tours_booking/utils/date_utils.dart/format_date.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../constants/app_padding.dart';
import '../../constants/svg_icons.dart';
import '../../views/bookings/booking_details.dart';
import '../app_button.dart';
import '../app_input_field.dart';
import '../containers/single_tour_container.dart';
import '../rating_bar/tour_rating_bar.dart';

class BookingWidget extends StatefulWidget {
  const BookingWidget({
    super.key,
  });

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  final BookingServices _bookingServices = BookingServices();
  final OngoingBookingsController _bookingsController = Get.put(OngoingBookingsController());
  GetAllPackages getpackageData = GetAllPackages();
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    await _bookingServices.getAllBookings();
    _bookingsController.searchBooking(
      allBooking: _bookingServices.allBookings,
    );
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.defaultPadding,
        child: GetBuilder<OngoingBookingsController>(
          init: OngoingBookingsController(),
          builder: (_) {
            return Column(
              children: [
                AppPadding.heightSpace30,
                AppInputField(
                  onChanged: (query) {
                    _.searchBooking(
                      allBooking: _bookingServices.allBookings,
                      query: query,
                    );
                  },
                  hintText: "search for tours",
                  contentPadding: const EdgeInsets.only(top: 20),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: SvgPicture.string(
                      SvgIcons.search,
                    ),
                  ),
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _bookingServices.allBookings.isEmpty
                        ? const Center(
                            child: AppText(text: "NO booking yet!"),
                          )
                        : Column(
                            children: List.generate(
                              _.allBookings.length,
                              (index) {
                                return Column(
                                  children: [
                                    AppPadding.heightSpace30,
                                    FutureBuilder<PackagesModel>(
                                      future: getpackageData.getPackageData(
                                        _.allBookings[index].tourId,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return SingleTourContainer(
                                            eventName: _.allBookings[index].eventName!,
                                            picUrl: snapshot.data!.thumbnailUrl,
                                            ratingBar: FutureBuilder(
                                                future: getpackageData.tourRating(
                                                  _.allBookings[index].tourId,
                                                ),
                                                builder: (context, snap) {
                                                  return TourRatingBar(
                                                    initialRating: snap.data == null ? 0.0 : double.parse(snap.data.toString()),
                                                  );
                                                }),
                                            bottomButton: Align(
                                              alignment: Alignment.bottomRight,
                                              child: RoundButton(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => BookingDetails(
                                                        bookingData: _.allBookings[index],
                                                        packageData: snapshot.data!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                text: "view",
                                              ),
                                            ),
                                            location: snapshot.data!.location!.address.toString(),
                                            startDate: FormatDate.formatedDate(
                                              formatPattern: "dd MMM",
                                              date: snapshot.data!.startDate.toString(),
                                            ),
                                            endDate: FormatDate.formatedDate(
                                              formatPattern: "dd MMM",
                                              date: snapshot.data!.endDate.toString(),
                                            ),
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
              ],
            );
          },
        ),
      ),
    );
  }
}
