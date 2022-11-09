import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/favorites/favorites.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

void main() {
  group('FavoritesBloc', () {
    late PokemonsRepository pokemonsRepository;

    const name1 = 'name1';
    const name2 = 'name2';

    const favorites = [name1, name2];

    setUpAll(() {
      registerFallbackValue(List<String>);
    });

    setUp(() {
      pokemonsRepository = MockPokemonsRepository();
    });

    FavoritesBloc buildBloc() {
      return FavoritesBloc(
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
            const FavoritesState(
              pokemons: <String>[],
              status: FavoritesStatus.loading,
            ),
          ),
        );
      });
    });

    group('FetchFavorites', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'attempts to get pokemons names from repository',
        setUp: () {
          when(
            () => pokemonsRepository.getFavorites(),
          ).thenAnswer((_) => favorites);
        },
        build: buildBloc,
        seed: () => const FavoritesState(
          pokemons: <String>[],
          status: FavoritesStatus.loading,
        ),
        act: (bloc) => bloc.add(
          const FetchFavorites(),
        ),
        expect: () => const [
          FavoritesState(
            pokemons: favorites,
            status: FavoritesStatus.display,
          ),
        ],
        verify: (bloc) {
          verify(
            () => pokemonsRepository.getFavorites(),
          ).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'emits new state with error if getFavorites from repository fails',
        build: () {
          when(
            () => pokemonsRepository.getFavorites(),
          ).thenThrow(Exception('oops'));
          return buildBloc();
        },
        seed: () => const FavoritesState(
          pokemons: <String>[],
          status: FavoritesStatus.loading,
        ),
        act: (bloc) => bloc.add(
          const FetchFavorites(),
        ),
        expect: () => const [
          FavoritesState(
            pokemons: <String>[],
            status: FavoritesStatus.error,
          ),
        ],
      );
    });

    group('ReorderFavorites', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'calls repository.reorderFavorites with proper favorites',
        setUp: () {
          when(
            () =>
                pokemonsRepository.reorderFavorites(favorites: [name1, name2]),
          ).thenAnswer((_) async {});

          when(
            () =>
                pokemonsRepository.reorderFavorites(favorites: [name2, name1]),
          ).thenAnswer((_) async {});

          when(
            () => pokemonsRepository.getFavorites(),
          ).thenAnswer((_) => [name1, name2]);
        },
        build: buildBloc,
        seed: () => const FavoritesState(
          pokemons: [name2, name1],
          status: FavoritesStatus.display,
        ),
        act: (bloc) => bloc.add(
          const ReorderFavorites(oldIndex: 0, newIndex: 1),
        ),
        expect: () => const [
          FavoritesState(
            pokemons: [name2, name1],
            status: FavoritesStatus.loading,
          ),
          FavoritesState(
            pokemons: [name1, name2],
            status: FavoritesStatus.display,
          ),
        ],
        verify: (bloc) {
          verify(
            () => pokemonsRepository.getFavorites(),
          ).called(1);

          verify(
            () => pokemonsRepository.reorderFavorites(
              favorites: [name2, name1],
            ),
          ).called(1);
        },
      );
    });
  });
}
