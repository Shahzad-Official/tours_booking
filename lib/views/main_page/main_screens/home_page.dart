import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tours_booking/controllers/main_page_controller/main_pages_controllers/home_controller.dart';
import 'package:tours_booking/services/package_services/get_all_packages.dart';

import '../../../constants/app_colors.dart';
import '../../../utils/date_utils.dart/calculate_days.dart';
import '../../../utils/date_utils.dart/format_date.dart';
import '../../../widgets/all_package_list.dart';
import '../../../widgets/app_text.dart';
import '../../single_package_page/tour_single_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final HomeController _controller = Get.put(HomeController());
  final GetAllPackages _getAllPackages = GetAllPackages();

  bool isLoading = false;
  getAllPackages() async {
    setState(() {
      isLoading = true;
    });
    await _getAllPackages.getAllPackages();

    _controller.searchPackage(
      packagesList: _getAllPackages.allPackages,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAllPackages();
    _controller.setCustomIcon();
    _controller.getMyCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.backgroundcolor,
        appBar: null,
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            if (_.isGettingLocation || _.markerIcon == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        AppBar(
                          elevation: 0.0,
                          backgroundColor: AppColors.backgroundcolor,
                          title: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SizedBox(
                              height: 60,
                              width: double.maxFinite,
                              child: TextFormField(
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.search,
                                  ),
                                  hintText: ' Place',
                                  fillColor: const Color(0xffEAE8F4),
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(33),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          leading: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Color(0xff302A4E),
                              size: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GoogleMap(
                            markers: List.generate(
                              _.allPackages.length,
                              (index) {
                                return Marker(
                                  onTap: () {
                                    _.checkIsTapped();
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 200,
                                          color: Colors.transparent,
                                          child: PackagesList(
                                            rating: 0,
                                            eventImage: _
                                                .allPackages[index].thumbnailUrl
                                                .toString(),
                                            eventName: _
                                                .allPackages[index].packageName
                                                .toString(),
                                            eventDate:
                                                "${FormatDate.formatedDate(
                                              formatPattern: "dd MMM",
                                              date: _
                                                  .allPackages[index].startDate
                                                  .toString(),
                                            )}-${FormatDate.formatedDate(
                                              formatPattern: "dd MMM",
                                              date: _.allPackages[index].endDate
                                                  .toString(),
                                            )}",
                                            eventLocation: _.allPackages[index]
                                                .location!.address
                                                .toString(),
                                            eventDuration:
                                                CalculateDays.daysBetweenDates(
                                              startDate: _
                                                  .allPackages[index].startDate
                                                  .toString(),
                                              endDate: _
                                                  .allPackages[index].endDate
                                                  .toString(),
                                            ).isNegative
                                                    ? "E"
                                                    : CalculateDays
                                                        .daysBetweenDates(
                                                        startDate: _
                                                            .allPackages[index]
                                                            .startDate
                                                            .toString(),
                                                        endDate: _
                                                            .allPackages[index]
                                                            .endDate
                                                            .toString(),
                                                      ).inDays.toString(),
                                            eventDurationColor: CalculateDays
                                                        .daysBetweenDates(
                                                      startDate: _
                                                          .allPackages[index]
                                                          .startDate
                                                          .toString(),
                                                      endDate: _
                                                          .allPackages[index]
                                                          .endDate
                                                          .toString(),
                                                    ).inDays >=
                                                    3
                                                ? Colors.red
                                                : CalculateDays
                                                            .daysBetweenDates(
                                                          startDate: _
                                                              .allPackages[
                                                                  index]
                                                              .startDate
                                                              .toString(),
                                                          endDate: _
                                                              .allPackages[
                                                                  index]
                                                              .endDate
                                                              .toString(),
                                                        ).inDays ==
                                                        2
                                                    ? Colors.yellow
                                                    : CalculateDays
                                                            .daysBetweenDates(
                                                        startDate: _
                                                            .allPackages[index]
                                                            .startDate
                                                            .toString(),
                                                        endDate: _
                                                            .allPackages[index]
                                                            .endDate
                                                            .toString(),
                                                      ).isNegative
                                                        ? Colors.purple
                                                        : Colors.green,
                                            onTap:
                                                CalculateDays.daysBetweenDates(
                                              startDate: _
                                                  .allPackages[index].startDate
                                                  .toString(),
                                              endDate: _
                                                  .allPackages[index].endDate
                                                  .toString(),
                                            ).isNegative
                                                    ? () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return const AlertDialog(
                                                              title: AppText(
                                                                text:
                                                                    "Package Expired!",
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    : () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                PackageSinglePage(
                                                              packageData:
                                                                  _.allPackages[
                                                                      index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon:
                                      BitmapDescriptor.fromBytes(_.markerIcon!),
                                  markerId: MarkerId("$index"),
                                  position: LatLng(
                                    _.allPackages[index].location!.latitude!,
                                    _.allPackages[index].location!.longitude!,
                                  ),
                                );
                              },
                            ).toSet(),
                            initialCameraPosition: _.initialPosition(
                              lat: _.allPackages[0].location!.latitude!,
                              long: _.allPackages[0].location!.longitude!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
