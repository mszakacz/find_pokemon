// ignore_for_file: avoid_redundant_argument_values

import 'package:pokemons_api/pokemons_api.dart';
import 'package:test/test.dart';

void main() {
  group('PokemonData', () {
    const sprites = SpritesData(
      backDefault: 'backDefault.url',
      backFemale: 'backFemale.url',
      backShiny: 'backShiny.url',
      backShinyFemale: 'backShinyFemale.url',
      frontDefault: 'frontDefault.url',
      frontFemale: 'frontFemale.url',
      frontShiny: 'frontShiny.url',
      frontShinyFemale: 'frontShinyFemale.url',
    );

    const spritesJson = <String, dynamic>{
      'back_default': 'backDefault.url',
      'back_female': 'backFemale.url',
      'back_shiny': 'backShiny.url',
      'back_shiny_female': 'backShinyFemale.url',
      'front_default': 'frontDefault.url',
      'front_female': 'frontFemale.url',
      'front_shiny': 'frontShiny.url',
      'front_shiny_female': 'frontShinyFemale.url',
    };

    const stats = [
      PokemonStatData(
        value: 1,
        effort: 1,
        stat: StatData(
          name: 'statName',
          url: 'stat.url',
        ),
      ),
    ];

    const statsJson = [
      <String, dynamic>{
        'base_stat': 1,
        'effort': 1,
        'stat': <String, dynamic>{
          'name': 'statName',
          'url': 'stat.url',
        },
      },
    ];

    PokemonData createSubject({
      int id = 1,
      String name = 'name',
      SpritesData sprites = sprites,
      List<PokemonStatData> stats = stats,
      int weight = 1,
      int height = 1,
    }) {
      return PokemonData(
        id: id,
        name: name,
        sprites: sprites,
        stats: stats,
        weight: weight,
        height: height,
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
          1, // id
          'name', // name
          sprites, // sprites
          stats, //stats
          1, //weight
          1, // height
        ]),
      );
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          PokemonData.fromJson(
            const <String, dynamic>{
              'id': 1,
              'name': 'name',
              'sprites': spritesJson,
              'stats': statsJson,
              'weight': 1,
              'height': 1,
            },
          ),
          equals(createSubject()),
        );
      });
    });
  });
}
