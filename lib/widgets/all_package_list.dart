import 'package:flutter/material.dart';
import 'app_text.dart';

class PackagesList extends StatelessWidget {
  String eventImage, eventName, eventDate, eventLocation, eventDuration;
  Color eventDurationColor;
  void Function()? onTap;
  PackagesList({
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
                  image: DecorationImage(
                      image: AssetImage(eventImage), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(text: eventName, fontSize: 18),
                        AppText(text: eventDate, fontSize: 14),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                            ),
                            AppText(text: eventLocation, fontSize: 14),
                          ],
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 38,
                          width: 38,
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
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          width: 40,
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
