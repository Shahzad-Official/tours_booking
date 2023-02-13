import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tours_booking/constants/svg_icons.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/app_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.backgroundcolor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(95),
          child: AppBar(
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
                        borderSide: BorderSide.none),
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
            bottom: TabBar(
                labelColor: const Color(0xff302A4E),
                indicatorColor: const Color(0xff302A4E),
                unselectedLabelColor: const Color(0xffC4C4C4),
                isScrollable: true,
                tabs: [
                  AppText(
                    text: "Temple",
                    fontSize: 13,
                  ),
                  AppText(
                    text: "Hotels",
                    fontSize: 13,
                  ),
                  AppText(
                    text: "People",
                    fontSize: 13,
                  ),
                  AppText(
                    text: "Comunity",
                    fontSize: 13,
                  ),
                  AppText(
                    text: "Event",
                    fontSize: 13,
                  ),
                ]),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/map.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                          width: MediaQuery.of(context).size.width * 0.75,
                          image: const AssetImage("assets/locationgroup.png")),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          height: 65,
                          width: 65,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff3FAFFF),
                          ),
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/map.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/map.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/map.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/map.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
