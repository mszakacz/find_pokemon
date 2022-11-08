import 'dart:core';

import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';
import 'package:test/test.dart';

void main() {
  group('pokemonStats', () {
    test('returns list which length is equal to stats length', () {
      const length = 5;
      final stats = List.generate(
        length,
        (int index) => PokemonStatData(
          value: index,
          effort: index,
          stat: StatData(name: 'name$index', url: 'url$index'),
        ),
      );
      equals(pokemonStats(stats: stats), length);
    });

    test('returns stats from list of PokemonStatData', () {
      const length = 6;

      final stats = List.generate(
        length,
        (int index) => PokemonStatData(
          value: index,
          effort: index,
          stat: StatData(
            name: 'name$index',
            url: 'url$index',
          ),
        ),
      );

      final expected = List.generate(
        length,
        (int index) => Stat(
          value: index,
          effort: index,
          name: 'name$index',
        ),
      );

      expect(
        pokemonStats(stats: stats),
        expected,
      );
    });
  });
}
