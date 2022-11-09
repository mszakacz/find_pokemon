// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

void main() {
  const mockPokemon = Pokemon(
    id: 1,
    name: 'name',
    pictures: ['pic'],
    stats: [
      Stat(
        value: 1,
        effort: 1,
        name: 'statName',
      ),
    ],
    weight: 1,
    height: 1,
  );

  const mockPokemon2 = Pokemon(
    id: 2,
    name: 'name2',
    pictures: ['pic2'],
    stats: [
      Stat(
        value: 2,
        effort: 2,
        name: 'statName2',
      ),
    ],
    weight: 2,
    height: 2,
  );

  group('PokemonDetailsState', () {
    PokemonDetailsState createSubject({
      PokemonDetailsStatus status = PokemonDetailsStatus.loading,
      Pokemon? pokemon,
      bool isFavorite = false,
    }) {
      return PokemonDetailsState(
        status: status,
        pokemon: pokemon ?? mockPokemon,
        isFavorite: isFavorite,
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
          status: PokemonDetailsStatus.display,
          pokemon: mockPokemon,
          isFavorite: true,
        ).props,
        equals(<Object?>[
          PokemonDetailsStatus.display, // status
          mockPokemon, // pokemon
          true, // isFavorite
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
            status: null,
            pokemon: null,
            isFavorite: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            status: PokemonDetailsStatus.display,
            pokemon: mockPokemon2,
            isFavorite: true,
          ),
          equals(
            createSubject(
              status: PokemonDetailsStatus.display,
              pokemon: mockPokemon2,
              isFavorite: true,
            ),
          ),
        );
      });
    });
  });
}
