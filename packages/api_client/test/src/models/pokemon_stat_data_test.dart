// ignore_for_file: avoid_redundant_argument_values

import 'package:api_client/api_client.dart';
import 'package:test/test.dart';

void main() {
  group('PokemonStatData', () {
    const stat = StatData(
      name: 'statName',
      url: 'stat.url',
    );

    const json = <String, dynamic>{
      'base_stat': 1,
      'effort': 1,
      'stat': <String, dynamic>{
        'name': 'statName',
        'url': 'stat.url',
      },
    };

    PokemonStatData createSubject({
      int value = 1,
      int effort = 1,
      StatData stat = stat,
    }) {
      return PokemonStatData(
        value: value,
        effort: effort,
        stat: stat,
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
          1, // base stat
          1, // effort
          stat, // stat
        ]),
      );
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          PokemonStatData.fromJson(
            json,
          ),
          equals(createSubject()),
        );
      });
    });
  });
}
