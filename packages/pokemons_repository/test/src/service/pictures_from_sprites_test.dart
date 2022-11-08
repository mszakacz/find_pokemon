import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';
import 'package:test/test.dart';

void main() {
  group('picturesFromSprites', () {
    test('returns empty list when all sprites are null', () {
      const sprites = SpritesData(
        backDefault: null,
        backFemale: null,
        backShiny: null,
        backShinyFemale: null,
        frontDefault: null,
        frontFemale: null,
        frontShiny: null,
        frontShinyFemale: null,
      );
      final pictures = picturesFromSprites(
        sprites: sprites,
      );
      equals(pictures.isEmpty);
    });

    group('returns list as big as number of not-nullable properties', () {
      test('1 element', () {
        const sprites = SpritesData(
          backDefault: 'backDefault',
          backFemale: null,
          backShiny: null,
          backShinyFemale: null,
          frontDefault: null,
          frontFemale: null,
          frontShiny: null,
          frontShinyFemale: null,
        );
        final pictures = picturesFromSprites(
          sprites: sprites,
        );
        equals(pictures.length, 1);
      });

      test('3 elements', () {
        const sprites = SpritesData(
          backDefault: 'backDefault',
          backFemale: null,
          backShiny: 'backShiny',
          backShinyFemale: null,
          frontDefault: 'frontDefault',
          frontFemale: null,
          frontShiny: null,
          frontShinyFemale: null,
        );
        final pictures = picturesFromSprites(
          sprites: sprites,
        );
        equals(pictures.length, 3);
      });
    });

    test('returns all sprites properties as list', () {
      const sprites = SpritesData(
        frontDefault: 'frontDefault',
        frontFemale: 'frontFemale',
        frontShiny: 'frontShiny',
        frontShinyFemale: 'frontShinyFemale',
        backDefault: 'backDefault',
        backFemale: 'backFemale',
        backShiny: 'backShiny',
        backShinyFemale: 'backShinyFemale',
      );
      final actual = picturesFromSprites(
        sprites: sprites,
      );

      final expected = <String>[
        'frontDefault',
        'frontFemale',
        'frontShiny',
        'frontShinyFemale',
        'backDefault',
        'backFemale',
        'backShiny',
        'backShinyFemale',
      ];
      expect(actual, expected);
    });
  });
}
