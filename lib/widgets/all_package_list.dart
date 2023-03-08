import 'package:flutter/material.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';
import 'app_text.dart';

class PackagesList extends StatelessWidget {
  final String eventImage, eventName, eventDate, eventLocation, eventDuration;
  final Color eventDurationColor;
  final void Function()? onTap;
  const PackagesList({
    Key? key,
    required this.eventImage,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.eventDuration,
    required this.eventDurationColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 15),
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 2),
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primarycolor,
                ),
                child: AppCachedImage(
                  picUrl: eventImage,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppText(text: eventName, fontSize: 18),
                          AppPadding.heightSpace10,
                          AppText(text: eventDate, fontSize: 14),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 14,
                                ),
                                Expanded(
                                  child: AppText(
                                    overflow: TextOverflow.ellipsis,
                                    text: eventLocation,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.circle,
                                  size: 16, color: Colors.blueAccent),
                              Icon(Icons.circle,
                                  size: 16, color: Colors.blueAccent),
                              Icon(Icons.circle,
                                  size: 16, color: Colors.blueAccent),
                              Icon(Icons.circle,
                                  size: 16, color: Colors.blueAccent),
                              Icon(Icons.circle,
                                  size: 16, color: Colors.blueAccent),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1, 2),
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: eventDurationColor,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1, 2),
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: AppText(
                              text: eventDuration,
                              fontSize: 8,
                              textcolor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
