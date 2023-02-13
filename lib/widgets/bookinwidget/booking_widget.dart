import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_padding.dart';
import '../../constants/svg_icons.dart';
import '../../controllers/bookings_controllers/ongoing_bookings_controller.dart';
import '../../views/bookings/booking_details.dart';
import '../app_button.dart';
import '../app_input_field.dart';
import '../containers/single_tour_container.dart';
import '../rating_bar/tour_rating_bar.dart';

class BookingWidget extends StatelessWidget {
  const BookingWidget({
    super.key,
    required this.bookingsController,
  });

  final OngoingBookingsController bookingsController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.defaultPadding,
        child: Column(
          children: [
            AppPadding.heightSpace30,
            AppInputField(
              hintText: "search for tours",
              contentPadding: const EdgeInsets.only(top: 20),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: SvgPicture.string(
                  SvgIcons.search,
                ),
              ),
            ),
            Column(
              children:
                  List.generate(bookingsController.eventList.length, (index) {
                return Column(
                  children: [
                    AppPadding.heightSpace30,
                    SingleTourContainer(
                      eventName: bookingsController.eventList[index].name!,
                      location: bookingsController.eventList[index].location!,
                      picUrl: bookingsController.eventList[index].coverImage!,
                      ratingBar: TourRatingBar(
                        initialRating: index == 2 ? 3 : null,
                      ),
                      bottomButton: Align(
                        alignment: Alignment.bottomRight,
                        child: RoundButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingDetails(
                                  eventName:
                                      bookingsController.eventList[index].name!,
                                  picUrl: bookingsController
                                      .eventList[index].coverImage!,
                                ),
                              ),
                            );
                          },
                          text: "view",
                        ),
                      ),
                      startDate: "12 Mar",
                      endDate: "2 May",
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
