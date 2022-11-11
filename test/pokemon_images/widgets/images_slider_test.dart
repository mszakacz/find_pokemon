import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/pokemon_images/pokemon_images.dart';
import 'package:pokemon/widgets/widgets.dart';
import '../../helpers/helpers.dart';

void main() {
  const pictures = ['pic1', 'pic2', 'pic3'];

  group('ImagesSlider', () {
    Widget buildSubject() {
      return const ImagesSlider(pictures: pictures);
    }

    testWidgets('renders CarouselSlider with as many items as pictures',
        (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(CarouselSlider), findsOneWidget);

      final carouselSlider = tester.widget<CarouselSlider>(
        find.byType(CarouselSlider),
      );

      expect(carouselSlider.items!.length, pictures.length);
    });

    testWidgets('creates CachedImg-s with proper url', (tester) async {
      await tester.pumpApp(buildSubject());

      final items = tester
          .widget<CarouselSlider>(
            find.byType(CarouselSlider),
          )
          .items;

      for (var i = 0; i < items!.length; i++) {
        final item = items[i] as CachedImg;
        expect(item.pictureUrl, pictures[i]);
      }
    });
  });
}
