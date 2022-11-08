import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Stat', () {
    const pokemonStatData = PokemonStatData(
      value: 1,
      effort: 1,
      stat: StatData(
        name: 'statName',
        url: 'stat.url',
      ),
    );

    Stat createSubject({
      int value = 1,
      int effort = 1,
      String name = 'statName',
    }) {
      return Stat(
        value: value,
        effort: effort,
        name: name,
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
        equals(
          [
            1, // value
            1, // effort
            'statName', // name
          ],
        ),
      );
    });

    group('fromData', () {
      test('works correctly', () {
        expect(
          Stat.fromData(pokemonStatData),
          equals(createSubject()),
        );
      });
    });
  });
}
