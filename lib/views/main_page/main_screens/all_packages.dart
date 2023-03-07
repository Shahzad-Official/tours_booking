import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/dummy_data.dart';
import 'package:tours_booking/views/single_package_page/tour_single_page.dart';
import 'package:tours_booking/widgets/all_package_list.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../../constants/svg_icons.dart';
import '../../../widgets/filter_sheet.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({Key? key}) : super(key: key);

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> {
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
                      AppText(
                        text: "All Packages",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      AppCircularCachedImage(
                        picRadius: 20,
                        picUrl: DummyData.profilePic,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: AppPadding.defaultPadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: 60,
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
                      packagesListData.length,
                      (index) {
                        return PackagesList(
                          eventImage: packagesListData[index]["eventImage"],
                          eventName: packagesListData[index]["eventName"],
                          eventDate: packagesListData[index]["eventDate"],
                          eventLocation: packagesListData[index]
                              ["eventLocation"],
                          eventDuration: packagesListData[index]
                              ["eventDuration"],
                          eventDurationColor: packagesListData[index]
                              ["eventDurationColor"],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PackageSinglePage(),
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
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> packagesListData = [
    {
      "eventImage": "assets/image2.png",
      "eventName": "Event culture",
      "eventDate": "12 Feb - 1 March",
      "eventLocation": "Paris, Europe",
      "eventDuration": "3 Days",
      "eventDurationColor": const Color(0xffFF4A4A),
    },
    {
      "eventImage": "assets/image1.png",
      "eventName": "Event culture",
      "eventDate": "12 Feb - 1 March",
      "eventLocation": "Paris, Europe",
      "eventDuration": "2 Days",
      "eventDurationColor": const Color(0xffDEA042),
    },
    {
      "eventImage": "assets/image1.png",
      "eventName": "Event culture",
      "eventDate": "12 Feb - 1 March",
      "eventLocation": "Paris, Europe",
      "eventDuration": "0 Days",
      "eventDurationColor": const Color(0xff12AD0F),
    },
    {
      "eventImage": "assets/image1.png",
      "eventName": "Event culture",
      "eventDate": "12 Feb - 1 March",
      "eventLocation": "Paris, Europe",
      "eventDuration": "3 Days",
      "eventDurationColor": const Color(0xffFF4A4A),
    },
    {
      "eventImage": "assets/image1.png",
      "eventName": "Event culture",
      "eventDate": "12 Feb - 1 March",
      "eventLocation": "Paris, Europe",
      "eventDuration": "3 Days",
      "eventDurationColor": const Color(0xffFF4A4A),
    },
  ];
}
