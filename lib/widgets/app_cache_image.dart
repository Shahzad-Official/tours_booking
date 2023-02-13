import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppCircularCachedImage extends StatelessWidget {
  String picUrl;
  double? picRadius;
  AppCircularCachedImage({
    Key? key,
    required this.picUrl,
    this.picRadius = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: picUrl,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: picRadius,
          backgroundImage: imageProvider,
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return CircularProgressIndicator(
          value: progress.progress,
        );
      },
    );
  }
}

class AppCachedImage extends StatelessWidget {
  String picUrl;
  double borderRadius;
  AppCachedImage({
    Key? key,
    required this.picUrl,
    this.borderRadius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: picUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            value: progress.progress,
          ),
        );
      },
    );
  }
}
