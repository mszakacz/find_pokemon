import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/widgets/widgets.dart';

class ImagesSlider extends StatelessWidget {
  const ImagesSlider({
    super.key,
    required this.pictures,
  });

  final List<String> pictures;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final size = screenWidth;

    final items = <Widget>[];
    for (final picture in pictures) {
      items.add(
        CachedImg(
          pictureUrl: picture,
          borderRadius: 0,
          height: screenWidth,
          width: screenWidth,
        ),
      );
    }
    return CarouselSlider(
      options: CarouselOptions(
        height: size,
        viewportFraction: 1,
      ),
      items: items,
    );
  }
}
