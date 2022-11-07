// ignore_for_file: avoid_redundant_argument_values

import 'package:api_client/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StatData', () {
    const json = <String, dynamic>{
      'name': 'statName',
      'url': 'stat.url',
    };

    StatData createSubject({
      String name = 'statName',
      String url = 'stat.url',
    }) {
      return StatData(
        name: name,
        url: url,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals([
          'statName',
          'stat.url',
        ]),
      );
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          StatData.fromJson(
            json,
          ),
          equals(createSubject()),
        );
      });
    });
  });
}
