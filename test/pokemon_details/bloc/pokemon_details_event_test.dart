import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';

void main() {
  group('PokemonDetailsEvent', () {
    const pokemonName = 'pokemonName';

    group('FetchPokemonDetails', () {
      test('supports value equality', () {
        expect(
          const FetchPokemonDetails(
            pokemonName: pokemonName,
          ),
          equals(
            const FetchPokemonDetails(
              pokemonName: pokemonName,
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          const FetchPokemonDetails(
            pokemonName: pokemonName,
          ).props,
          equals(<Object?>[
            pokemonName,
          ]),
        );
      });
    });

    group('AddToFavorite', () {
      test('supports value equality', () {
        expect(
          const AddToFavorite(
            isFavorite: true,
          ),
          equals(
            const AddToFavorite(
              isFavorite: true,
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          const AddToFavorite(
            isFavorite: true,
          ).props,
          equals(<Object?>[
            true, // isFavorite
          ]),
        );
      });
    });
  });
}
