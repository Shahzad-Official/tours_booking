import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/controllers/main_page_controller/main_pages_controllers/all_packages_controller.dart';
import 'package:tours_booking/models/user_profile/profile_model.dart';
import 'package:tours_booking/services/package_services/get_all_packages.dart';
import 'package:tours_booking/utils/date_utils.dart/calculate_days.dart';
import 'package:tours_booking/utils/date_utils.dart/format_date.dart';
import 'package:tours_booking/views/single_package_page/tour_single_page.dart';
import 'package:tours_booking/widgets/all_package_list.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../../constants/svg_icons.dart';
import '../../../widgets/filter_sheet.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({super.key});

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final GetAllPackages _getAllPackages = GetAllPackages();
  final AllPackagesController _controller = Get.put(AllPackagesController());
  bool isLoading = false;
  ProfileModel userData = ProfileModel();
  getAllPackages() async {
    Box box = Hive.box("DataBox");

    userData = ProfileModel.fromJson(
      box.get("userData"),
    );
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
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: AppPadding.defaultPadding,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text: "All Packages",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      AppCircularCachedImage(
                        picRadius: 20,
                        picUrl:
                            userData.profile == "" || userData.profile == null
                                ? DummyData.profilePic
                                : userData.profile!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: GetBuilder<AllPackagesController>(
            init: AllPackagesController(),
            builder: (_) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (_controller.allPackages.isEmpty) {
                return const Center(
                  child: AppText(text: "NO package Available!"),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: AppPadding.defaultPadding,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(1, 2),
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  _.searchPackage(
                                    packagesList: _getAllPackages.allPackages,
                                    query: value,
                                  );
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Search for tours',
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10))),
                                context: context,
                                builder: (context) {
                                  return const FractionallySizedBox(
                                    heightFactor: 0.75,
                                    child: FilterSheet(),
                                  );
                                },
                              ),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.16,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(1, 2),
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: SvgPicture.string(
                                    SvgIcons.filter,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: List<Widget>.generate(
                            _.allPackages.length,
                            (index) {
                              return PackagesList(
                                rating: 0,
                                eventImage: _.allPackages[index].thumbnailUrl
                                    .toString(),
                                eventName:
                                    _.allPackages[index].packageName.toString(),
                                eventDate: "${FormatDate.formatedDate(
                                  formatPattern: "dd MMM",
                                  date:
                                      _.allPackages[index].startDate.toString(),
                                )}-${FormatDate.formatedDate(
                                  formatPattern: "dd MMM",
                                  date: _.allPackages[index].endDate.toString(),
                                )}",
                                eventLocation: _
                                    .allPackages[index].location!.address
                                    .toString(),
                                eventDuration: CalculateDays.daysBetweenDates(
                                  endDate:
                                      _.allPackages[index].endDate.toString(),
                                ).isNegative
                                    ? "E"
                                    : CalculateDays.daysBetweenDates(
                                        endDate: _.allPackages[index].endDate
                                            .toString(),
                                      ).toString(),
                                eventDurationColor:
                                    CalculateDays.daysBetweenDates(
                                              endDate: _
                                                  .allPackages[index].endDate
                                                  .toString(),
                                            ) >=
                                            3
                                        ? Colors.red
                                        : CalculateDays.daysBetweenDates(
                                                  endDate: _.allPackages[index]
                                                      .endDate
                                                      .toString(),
                                                ) ==
                                                2
                                            ? Colors.yellow
                                            : CalculateDays.daysBetweenDates(
                                                endDate: _
                                                    .allPackages[index].endDate
                                                    .toString(),
                                              ).isNegative
                                                ? Colors.purple
                                                : Colors.green,
                                onTap: CalculateDays.daysBetweenDates(
                                  endDate:
                                      _.allPackages[index].endDate.toString(),
                                ).isNegative
                                    ? () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const AppText(
                                                text: "Package Expired!",
                                              ),
                                              content: Lottie.asset(
                                                'assets/animations/expire.json',
                                                controller:
                                                    _animationController,
                                                onLoaded: (composition) {
                                                  _animationController
                                                    ..duration =
                                                        composition.duration
                                                    ..forward();
                                                  Timer(
                                                    composition.duration,
                                                    () {
                                                      Get.back();
                                                    },
                                                  );
                                                },
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
                                              packageData: _.allPackages[index],
                                            ),
                                          ),
                                        );
                                      },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
