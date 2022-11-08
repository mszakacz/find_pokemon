import 'package:mocktail/mocktail.dart';
import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';
import 'package:test/test.dart';

class MockPokemonsApiClient extends Mock implements PokemonsApiClient {}

class MockPokemonData extends Mock implements PokemonData {}

class FakePokemon extends Fake implements Pokemon {}

void main() {
  group('PokemonsRepository', () {
    late PokemonsApiClient api;
    late PokemonsRepository repository;

    const id = 1;
    const pokemonName = 'name';

    const weight = 1;
    const height = 1;

    const pokemon = Pokemon(
      id: id,
      name: pokemonName,
      pictures: [
        'frontDefault.jpg',
      ],
      stats: [
        Stat(
          value: 1,
          effort: 1,
          name: 'statName',
        ),
      ],
      weight: weight,
      height: height,
    );

    const sprites = SpritesData(
      backDefault: null,
      backFemale: null,
      backShiny: null,
      backShinyFemale: null,
      frontDefault: 'frontDefault.jpg',
      frontFemale: null,
      frontShiny: null,
      frontShinyFemale: null,
    );

    const stats = [
      PokemonStatData(
        value: 1,
        effort: 1,
        stat: StatData(
          name: 'statName',
          url: 'url',
        ),
      ),
    ];

    setUp(() {
      api = MockPokemonsApiClient();
      repository = PokemonsRepository(
        pokemonsApiClient: api,
      );
    });

    PokemonsRepository createSubject() => PokemonsRepository(
          pokemonsApiClient: api,
        );

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('searchPokemons', () {
      test('calls api.searchPokemons', () async {
        try {
          await repository.searchPokemons(phrase: pokemonName);
        } catch (_) {}

        verify(() => api.searchPokemons(phrase: pokemonName)).called(1);
      });

      test('returns names', () async {
        when(
          () => api.searchPokemons(phrase: pokemonName),
        ).thenAnswer(
          (_) async => [pokemonName],
        );

        final actual = await repository.searchPokemons(phrase: pokemonName);

        expect(
          actual,
          [pokemonName],
        );
      });
    });

    group('getPokemon', () {
      test('calls api.getPokemon', () async {
        try {
          await repository.getPokemon(name: pokemonName);
        } catch (_) {}

        verify(() => api.getPokemon(pokemonName: pokemonName)).called(1);
      });

      test('returns pokemon', () async {
        final pokemonData = MockPokemonData();
        when(() => pokemonData.id).thenReturn(id);
        when(() => pokemonData.name).thenReturn(pokemonName);
        when(() => pokemonData.sprites).thenReturn(sprites);
        when(() => pokemonData.stats).thenReturn(stats);
        when(() => pokemonData.weight).thenReturn(weight);
        when(() => pokemonData.height).thenReturn(height);

        when(
          () => api.getPokemon(pokemonName: pokemonName),
        ).thenAnswer(
          (_) async => pokemonData,
        );

        final actual = await repository.getPokemon(name: pokemonName);

        expect(
          actual,
          pokemon,
        );
      });
    });
  });
}
