import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:pokemon/theme/app_colors.dart';

class CachedImg extends StatelessWidget {
  const CachedImg({
    super.key,
    required this.pictureUrl,
    required this.borderRadius,
    required this.height,
    required this.width,
  });

  final String pictureUrl;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppColors.white,
      ),
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: SizedBox(
            height: height / 2,
            width: width / 2,
            child: const CircularProgressIndicator(),
          ),
        ),
        imageUrl: pictureUrl,
        errorWidget: (context, url, dynamic error) => const Icon(
          Icons.no_photography_outlined,
        ),
        imageBuilder: (context, imageProvider) => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
          ),
        ),
      ),
    );
  }
}
