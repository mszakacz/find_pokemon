// ignore_for_file: avoid_redundant_argument_values

import 'package:pokemons_api/pokemons_api.dart';

import 'package:test/test.dart';

void main() {
  group('SpritesData', () {
    const json = <String, dynamic>{
      'back_default': 'backDefault.url',
      'back_female': 'backFemale.url',
      'back_shiny': 'backShiny.url',
      'back_shiny_female': 'backShinyFemale.url',
      'front_default': 'frontDefault.url',
      'front_female': 'frontFemale.url',
      'front_shiny': 'frontShiny.url',
      'front_shiny_female': 'frontShinyFemale.url',
    };

    SpritesData createSubject({
      String backDefault = 'backDefault.url',
      String backFemale = 'backFemale.url',
      String backShiny = 'backShiny.url',
      String backShinyFemale = 'backShinyFemale.url',
      String frontDefault = 'frontDefault.url',
      String frontFemale = 'frontFemale.url',
      String frontShiny = 'frontShiny.url',
      String frontShinyFemale = 'frontShinyFemale.url',
    }) {
      return SpritesData(
        backDefault: backDefault,
        backFemale: backFemale,
        backShiny: backShiny,
        backShinyFemale: backShinyFemale,
        frontDefault: frontDefault,
        frontFemale: frontFemale,
        frontShiny: frontShiny,
        frontShinyFemale: frontShinyFemale,
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
          'backDefault.url',
          'backFemale.url',
          'backShiny.url',
          'backShinyFemale.url',
          'frontDefault.url',
          'frontFemale.url',
          'frontShiny.url',
          'frontShinyFemale.url',
        ]),
      );
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          SpritesData.fromJson(
            json,
          ),
          equals(createSubject()),
        );
      });
    });
  });
}
