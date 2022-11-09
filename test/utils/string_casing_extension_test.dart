import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/utils/utils.dart';

void main() {
  group('StringCasingExtension', () {
    group('toCapitalized', () {
      test('returns capitalized string', () {
        const string = 'pikachu';
        final actual = string.toCapitalized();

        const expected = 'Pikachu';

        expect(
          actual,
          expected,
        );
      });
    });

    group('asPokemonName', () {
      test('returns string as pokemon name', () {
        const string = 'pikachu-rock-star';
        final actual = string.asPokemonName();

        const expected = 'Pikachu (rock star)';

        expect(
          actual,
          expected,
        );
      });
    });
  });
}
