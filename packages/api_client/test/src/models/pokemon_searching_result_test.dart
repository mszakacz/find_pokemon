// ignore_for_file: avoid_redundant_argument_values

import 'package:api_client/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PokemonSearchingResult', () {
    const json = <String, dynamic>{
      'name': 'name',
      'url': 'result.url',
    };

    PokemonSearchingResult createSubject({
      String name = 'name',
      String url = 'result.url',
    }) {
      return PokemonSearchingResult(
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
          'name', // name
          'result.url', // url
        ]),
      );
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          PokemonSearchingResult.fromJson(
            json,
          ),
          equals(createSubject()),
        );
      });
    });
  });
}
