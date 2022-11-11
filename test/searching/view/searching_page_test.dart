import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/searching/searching.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

void main() {
  const mockPokemons = <String>['name1', 'name2', 'name3'];

  late PokemonsRepository pokemonsRepository;

  setUp(() {
    pokemonsRepository = MockPokemonsRepository();
    when(
      () => pokemonsRepository.searchPokemons(phrase: ''),
    ).thenAnswer((_) async => mockPokemons);
  });

  group('SearchingPage', () {
    testWidgets('renders SearchingInput in AppBar', (tester) async {
      await tester.pumpApp(const SearchingPage());

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(SearchingInput), findsOneWidget);
    });

    testWidgets('renders SearchingBody', (tester) async {
      await tester.pumpApp(const SearchingPage());

      expect(find.byType(SearchingBody), findsOneWidget);
    });

    testWidgets(
      'fetch pokemons from repository on initialization',
      (tester) async {
        await tester.pumpApp(
          const SearchingPage(),
          pokemonsRepository: pokemonsRepository,
        );

        verify(() => pokemonsRepository.searchPokemons(phrase: '')).called(1);
      },
    );
  });
}
