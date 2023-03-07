import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tours_booking/constants/svg_icons.dart';
import 'package:tours_booking/controllers/main_page_controller/main_pages_controllers/home_controller.dart';

import '../../../constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = Get.put(HomeController());
  @override
  void initState() {
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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.backgroundcolor,
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.55,
              child: TextFormField(
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
          actions: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 12, right: 10, bottom: 12),
                child: SvgPicture.string(SvgIcons.filter),
              ),
            )
          ],
        ),
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            if (_.isGettingLocation || _.markerIcon == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GoogleMap(
                    markers: {
                      Marker(
                        onTap: () {
                          _.checkIsTapped();
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 200,
                                color: Colors.red,
                              );
                            },
                          );
                        },
                        icon: BitmapDescriptor.fromBytes(_.markerIcon!),
                        markerId: const MarkerId("1"),
                        position: LatLng(
                          _controller.latitude!,
                          _controller.longitude!,
                        ),
                      ),
                    },
                    initialCameraPosition: _.initialPosition(),
                  ),
                  _.isTapped
                      ? Container(
                          height: 200,
                          width: double.infinity,
                          margin: const EdgeInsets.all(30),
                          color: Colors.red,
                        )
                      : const SizedBox(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
