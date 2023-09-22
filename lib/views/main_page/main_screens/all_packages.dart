import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/controllers/main_page_controller/main_pages_controllers/all_packages_controller.dart';
import 'package:tours_booking/models/packages/packages_model.dart';
import 'package:tours_booking/models/user_profile/profile_model.dart';
import 'package:tours_booking/services/package_services/get_all_packages.dart';
import 'package:tours_booking/utils/date_utils.dart/calculate_days.dart';
import 'package:tours_booking/utils/date_utils.dart/format_date.dart';
import 'package:tours_booking/views/single_package_page/tour_single_page.dart';
import 'package:tours_booking/widgets/all_package_list.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../../constants/svg_icons.dart';
import '../../../widgets/filter_sheet.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({super.key});

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> {
  CalculateDays calculateDays = CalculateDays();
  final GetAllPackages _getAllPackages = GetAllPackages();
  final AllPackagesController _controller = Get.put(AllPackagesController());
  bool isLoading = false;
  ProfileModel userData = ProfileModel();
  List<PackagesModel> allPackages = [];
  getAllPackages() async {
    Box box = Hive.box("DataBox");

    userData = ProfileModel.fromJson(
      jsonDecode(jsonEncode(box.get("userData"))),
    );
    setState(() {
      isLoading = true;
    });
    await _getAllPackages.getAllPackages();

    _controller.searchPackage(
      packagesList: _getAllPackages.allPackages,
    );
    allPackages = _controller.allPackages;

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _controller.getMyCurrentLocation();

    getAllPackages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Padding(
              padding: AppPadding.defaultPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "All Packages",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
              } else if (_getAllPackages.allPackages.isEmpty) {
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
                                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
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
                                shape: const OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
                                context: context,
                                builder: (context) {
                                  return FractionallySizedBox(
                                    heightFactor: 0.75,
                                    child: FilterSheet(
                                      onTap: () {
                                        _.applyFilter(
                                          packagesList: _getAllPackages.allPackages,
                                        );
                                      },
                                    ),
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
                        _.allPackages.isEmpty
                            ? const Center(
                                child: AppText(text: "NO Package Available!"),
                              )
                            : Column(
                                children: List<Widget>.generate(
                                  _.allPackages.length,
                                  (index) {
                                    calculateDays.daysBetweenDates(
                                      endDate: _.allPackages[index].endDate.toString(),
                                      endTime: _.allPackages[index].endTime.toString(),
                                      startTime: _.allPackages[index].startTime.toString(),
                                    );
                                    return PackagesList(
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
                                      eventDuration: calculateDays.isDays ? calculateDays.days.toString() : calculateDays.hour.toString(),
                                      eventDurationColor: calculateDays.isHours
                                          ? AppColors.day1Color
                                          : calculateDays.days >= 3
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
