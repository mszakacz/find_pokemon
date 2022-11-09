// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/favorites/favorites.dart';

void main() {
  const pokemonName = 'pokemonName';
  const mockPokemons = <String>[pokemonName];
  const mockPokemons2 = <String>['name1', 'name2'];

  group('FavoritesState', () {
    FavoritesState createSubject({
      List<String>? pokemons,
      FavoritesStatus status = FavoritesStatus.loading,
    }) {
      return FavoritesState(
        status: status,
        pokemons: pokemons ?? mockPokemons,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject(
          pokemons: mockPokemons,
          status: FavoritesStatus.display,
        ).props,
        equals(<Object?>[
          mockPokemons, // pokemons
          FavoritesStatus.display, // status
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            pokemons: null,
            status: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            pokemons: mockPokemons2,
            status: FavoritesStatus.display,
          ),
          equals(
            createSubject(
              pokemons: mockPokemons2,
              status: FavoritesStatus.display,
            ),
          ),
        );
      });
    });
  });
}
