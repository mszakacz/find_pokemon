import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

class FakePokemon extends Fake implements Pokemon {}

void main() {
  group('PokemonDetailsBloc', () {
    late PokemonsRepository pokemonsRepository;

    const pokemonName = 'name';

    const pokemon = Pokemon(
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

    setUpAll(() {
      registerFallbackValue(FakePokemon());
    });

    setUp(() {
      pokemonsRepository = MockPokemonsRepository();
    });

    PokemonDetailsBloc buildBloc() {
      return PokemonDetailsBloc(
        pokemonsRepository: pokemonsRepository,
      );
    }

    group('constructor', () {
      test('works properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(
            const PokemonDetailsState(
              status: PokemonDetailsStatus.loading,
              pokemon: Pokemon.empty,
              isFavorite: false,
            ),
          ),
        );
      });
    });

    group('FetchPokemonDetails', () {
      blocTest<PokemonDetailsBloc, PokemonDetailsState>(
        'attempts to get pokemon from repository',
        setUp: () {
          when(
            () => pokemonsRepository.getPokemon(name: pokemonName),
          ).thenAnswer((_) async => pokemon);

          when(
            () => pokemonsRepository.isFavorite(pokemonName: pokemonName),
          ).thenAnswer((_) => true);
        },
        build: buildBloc,
        seed: () => const PokemonDetailsState(
          status: PokemonDetailsStatus.loading,
          pokemon: Pokemon.empty,
          isFavorite: false,
        ),
        act: (bloc) => bloc.add(
          const FetchPokemonDetails(pokemonName: pokemonName),
        ),
        expect: () => const [
          PokemonDetailsState(
            status: PokemonDetailsStatus.display,
            pokemon: pokemon,
            isFavorite: true,
          ),
        ],
        verify: (bloc) {
          verify(
            () => pokemonsRepository.getPokemon(name: pokemonName),
          ).called(1);

          verify(
            () => pokemonsRepository.isFavorite(pokemonName: pokemonName),
          ).called(1);
        },
      );

      blocTest<PokemonDetailsBloc, PokemonDetailsState>(
        'emits new state with error if getPokemon from repository fails',
        build: () {
          when(
            () => pokemonsRepository.getPokemon(name: pokemonName),
          ).thenThrow(Exception('oops'));
          return buildBloc();
        },
        seed: () => const PokemonDetailsState(
          status: PokemonDetailsStatus.loading,
          pokemon: Pokemon.empty,
          isFavorite: false,
        ),
        act: (bloc) => bloc.add(
          const FetchPokemonDetails(pokemonName: pokemonName),
        ),
        expect: () => const [
          PokemonDetailsState(
            status: PokemonDetailsStatus.error,
            pokemon: Pokemon.empty,
            isFavorite: false,
          ),
        ],
      );
    });

    group('AddToFavorite', () {
      blocTest<PokemonDetailsBloc, PokemonDetailsState>(
        'attempts to addPokemonToFavorites for repository',
        setUp: () {
          when(
            () => pokemonsRepository.addPokemonToFavorites(
              pokemonName: pokemon.name,
            ),
          ).thenAnswer((_) async {});
        },
        build: buildBloc,
        seed: () => const PokemonDetailsState(
          status: PokemonDetailsStatus.display,
          pokemon: pokemon,
          isFavorite: false,
        ),
        act: (bloc) => bloc.add(
          const AddToFavorite(isFavorite: true),
        ),
        expect: () => const [
          PokemonDetailsState(
            status: PokemonDetailsStatus.display,
            pokemon: pokemon,
            isFavorite: true,
          ),
        ],
        verify: (bloc) {
          verify(
            () => pokemonsRepository.addPokemonToFavorites(
              pokemonName: pokemon.name,
            ),
          ).called(1);

          verifyNever(
            () => pokemonsRepository.removePokemonFromFavorites(
              pokemonName: pokemon.name,
            ),
          );
        },
      );

      blocTest<PokemonDetailsBloc, PokemonDetailsState>(
        'attempts to removePokemonFromFavorites for repository',
        setUp: () {
          when(
            () => pokemonsRepository.removePokemonFromFavorites(
              pokemonName: pokemon.name,
            ),
          ).thenAnswer((_) async {});
        },
        build: buildBloc,
        seed: () => const PokemonDetailsState(
          status: PokemonDetailsStatus.display,
          pokemon: pokemon,
          isFavorite: true,
        ),
        act: (bloc) => bloc.add(
          const AddToFavorite(isFavorite: false),
        ),
        expect: () => const [
          PokemonDetailsState(
            status: PokemonDetailsStatus.display,
            pokemon: pokemon,
            isFavorite: false,
          ),
        ],
        verify: (bloc) {
          verifyNever(
            () => pokemonsRepository.addPokemonToFavorites(
              pokemonName: pokemon.name,
            ),
          );

          verify(
            () => pokemonsRepository.removePokemonFromFavorites(
              pokemonName: pokemon.name,
            ),
          ).called(1);
        },
      );
    });
  });
}
