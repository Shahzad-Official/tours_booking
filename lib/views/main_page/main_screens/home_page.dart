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
  GoogleMapController? _mapController;
  CalculateDays calculateDays = CalculateDays();
  final HomeController _controller = Get.put(HomeController());
  final GetAllPackages _getAllPackages = GetAllPackages();

  bool isLoading = false;
  getAllPackages() async {
    setState(() {
      isLoading = true;
    });

    await _getAllPackages.getAllPackages();
    await _getAllPackages.getAllCategories();
    _controller.searchPackage(
      packagesList: _getAllPackages.allPackages,
    );
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
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
      length: _getAllPackages.allCats.length,
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
                return Column(
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
                            onFieldSubmitted: (value) {
                              _.searchPackage(
                                packagesList: _getAllPackages.allPackages,
                                query: value.toLowerCase(),
                              );
                              _mapController!.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      _.allPackages.first.location!.latitude!,
                                      _.allPackages.first.location!.longitude!,
                                    ),
                                    zoom: value.isEmpty ? 8 : 12,
                                  ),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                              ),
                              hintText: ' Place',
                              fillColor: const Color(0xffEAE8F4),
                              filled: true,
                              contentPadding: const EdgeInsets.only(left: 5),
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
                    TabBar(
                      labelColor: Colors.black,
                      isScrollable: true,
                      onTap: (value) {
                        _.categorizePackage(
                          packagesList: _getAllPackages.allPackages,
                          query: _getAllPackages.allCats[value].toLowerCase(),
                        );
                        if (_.allPackages.isNotEmpty) {
                          _mapController!.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _.allPackages.first.location!.latitude!,
                                  _.allPackages.first.location!.longitude!,
                                ),
                                zoom: _getAllPackages.allCats[value].isEmpty ? 8 : 12,
                              ),
                            ),
                          );
                        }
                      },
                      tabs: List.generate(
                        _getAllPackages.allCats.length,
                        (index) => Tab(
                          text: _getAllPackages.allCats[index],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _.allPackages.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(29.0),
                              child: Center(
                                child: AppText(
                                  text: "No package Available !",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : GoogleMap(
                              onMapCreated: (controller) async {
                                _mapController = controller;
                              },
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
                                          calculateDays.daysBetweenDates(
                                            endDate: _.allPackages[index].endDate.toString(),
                                            endTime: _.allPackages[index].endTime.toString(),
                                            startTime: _.allPackages[index].startTime.toString(),
                                          );
                                          return Container(
                                            height: 200,
                                            color: Colors.transparent,
                                            child: PackagesList(
                                              isHour: calculateDays.isHours,
                                              rating: 0,
                                              eventImage: _.allPackages[index].thumbnailUrl.toString(),
                                              eventName: _.allPackages[index].packageName.toString(),
                                              eventDate: "${FormatDate.formatedDate(
                                                formatPattern: "dd MMM",
                                                date: _.allPackages[index].startDate.toString(),
                                              )}-${FormatDate.formatedDate(
                                                formatPattern: "dd MMM",
                                                date: _.allPackages[index].endDate.toString(),
                                              )}",
                                              eventLocation: _.allPackages[index].location!.address.toString(),
                                              eventDuration: calculateDays
                                                  .daysBetweenDates(
                                                    endDate: _.allPackages[index].endDate.toString(),
                                                    endTime: _.allPackages[index].endTime.toString(),
                                                    startTime: _.allPackages[index].startTime.toString(),
                                                  )
                                                  .toString(),
                                              eventDurationColor: calculateDays.days >= 3
                                                  ? AppColors.day3Color
                                                  : calculateDays.days == 2
                                                      ? AppColors.day2Color
                                                      : AppColors.day1Color,
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => PackageSinglePage(
                                                      packageData: _.allPackages[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: BitmapDescriptor.fromBytes(_.markerIcon!),
                                    markerId: MarkerId("$index"),
                                    position: LatLng(
                                      _.allPackages[index].location!.latitude!,
                                      _.allPackages[index].location!.longitude!,
                                    ),
                                  );
                                },
                              ).toSet(),
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(-44.002480, 170.3909791),
                                zoom: 8,
                              ),
                            ),
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
