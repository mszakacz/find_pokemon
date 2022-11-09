import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/searching/searching.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

void main() {
  group('SearchingBloc', () {
    late PokemonsRepository pokemonsRepository;

    const phrase = 'na';
    const results = ['name'];

    setUpAll(() {
      registerFallbackValue(List<String>);
    });

    setUp(() {
      pokemonsRepository = MockPokemonsRepository();
    });

    SearchingBloc buildBloc() {
      return SearchingBloc(
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
            const SearchingState(
              status: SearchingStatus.loading,
              results: <String>[],
            ),
          ),
        );
      });
    });

    group('FetchPokemons', () {
      blocTest<SearchingBloc, SearchingState>(
        'attempts to searchPokemons from repository',
        setUp: () {
          when(
            () => pokemonsRepository.searchPokemons(phrase: phrase),
          ).thenAnswer((_) async => results);
        },
        build: buildBloc,
        seed: () => const SearchingState(
          status: SearchingStatus.loading,
          results: <String>[],
        ),
        act: (bloc) => bloc.add(
          const FetchPokemons(phrase: phrase),
        ),
        expect: () => const [
          SearchingState(
            status: SearchingStatus.display,
            results: results,
          ),
        ],
        verify: (bloc) {
          verify(
            () => pokemonsRepository.searchPokemons(phrase: phrase),
          ).called(1);
        },
      );

      blocTest<SearchingBloc, SearchingState>(
        'emits new state with error if searchPokemons from repository fails',
        build: () {
          when(
            () => pokemonsRepository.searchPokemons(phrase: phrase),
          ).thenThrow(Exception('oops'));
          return buildBloc();
        },
        seed: () => const SearchingState(
          status: SearchingStatus.loading,
          results: <String>[],
        ),
        act: (bloc) => bloc.add(
          const FetchPokemons(phrase: phrase),
        ),
        expect: () => const [
          SearchingState(
            status: SearchingStatus.error,
            results: <String>[],
          ),
        ],
      );
    });
  });
}
