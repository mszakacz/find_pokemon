import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Pokemon', () {
    const pokemonData = PokemonData(
      id: 1,
      name: 'name',
      sprites: SpritesData(
        frontDefault: 'pic',
        frontFemale: null,
        frontShiny: null,
        frontShinyFemale: null,
        backDefault: null,
        backFemale: null,
        backShiny: null,
        backShinyFemale: null,
      ),
      stats: [
        PokemonStatData(
          value: 1,
          effort: 1,
          stat: StatData(
            name: 'statName',
            url: 'stat.url',
          ),
        ),
      ],
      weight: 1,
      height: 1,
    );

    Pokemon createSubject({
      int id = 1,
      String name = 'name',
      List<String> pictures = const <String>[
        'pic',
      ],
      List<Stat> stats = const <Stat>[
        Stat(
          value: 1,
          effort: 1,
          name: 'statName',
        ),
      ],
      int weight = 1,
      int height = 1,
    }) {
      return Pokemon(
        id: id,
        name: name,
        pictures: pictures,
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
        equals(
          [
            1, // id
            'name', // name
            ['pic'], // pictures
            <Stat>[const Stat(value: 1, effort: 1, name: 'statName')], //stats
            1, //weight
            1, // height
          ],
        ),
      );
    });

    group('fromData', () {
      test('works correctly', () {
        expect(
          Pokemon.fromData(pokemonData),
          equals(createSubject()),
        );
      });
    });
  });
}
