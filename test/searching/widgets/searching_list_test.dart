import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/searching/searching.dart';
import 'package:pokemon/utils/utils.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

class MockSearchingBloc extends MockBloc<SearchingEvent, SearchingState>
    implements SearchingBloc {}

void main() {
  const mockPokemons = ['name1', 'name2', 'name3'];

  late PokemonsRepository pokemonsRepository;
  late MockNavigator navigator;
  late SearchingBloc searchingBloc;

  setUpAll(() {
    searchingBloc = MockSearchingBloc();
    when(() => searchingBloc.state).thenReturn(
      const SearchingState(
        status: SearchingStatus.display,
        results: mockPokemons,
      ),
    );
  });

  group('SearchingList', () {
    setUp(() {
      pokemonsRepository = MockPokemonsRepository();
      when(() => searchingBloc.state).thenReturn(
        const SearchingState(
          status: SearchingStatus.loading,
          results: <String>[],
        ),
      );
    });

    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: searchingBloc,
          child: const SearchingList(
            pokemons: mockPokemons,
          ),
        ),
      );
    }

    testWidgets(
        'renders NoPokemonsFound '
        'when pokemons is empty list', (tester) async {
      await tester.pumpApp(
        const SearchingList(
          pokemons: [],
        ),
        pokemonsRepository: pokemonsRepository,
      );

      expect(find.byType(NoPokemonsFound), findsOneWidget);
    });

    testWidgets(
        'renders ListView '
        'when pokemons is not empty list', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets(
        'renders SearchingListTile '
        'as many times as pokemons list length', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(
        find.byType(SearchingListTile),
        findsNWidgets(mockPokemons.length),
      );
    });

    testWidgets(
        'renders first SearchingListTile '
        'with correct pokemonName', (tester) async {
      await tester.pumpApp(buildSubject());

      final pokemon = mockPokemons[0];

      final listTile = tester.widget<SearchingListTile>(
        find.byKey(
          ValueKey('SearchingListTile-$pokemon'),
        ),
      );

      expect(
        listTile.pokemonName,
        pokemon,
      );
    });

    testWidgets(
        'renders all SearchingListTile s '
        'with correct pokemonName', (tester) async {
      await tester.pumpApp(buildSubject());

      for (final pokemon in mockPokemons) {
        final listTile = tester.widget<SearchingListTile>(
          find.byKey(
            ValueKey('SearchingListTile-$pokemon'),
          ),
        );

        expect(
          listTile.pokemonName,
          pokemon,
        );
      }
    });
  });

  group('SearchingListTile', () {
    const pokemonName = 'name';
    navigator = MockNavigator();

    when(() => navigator.push<void>(any())).thenAnswer((_) async {});

    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: searchingBloc,
          child: const SearchingListTile(
            pokemonName: pokemonName,
          ),
        ),
      );
    }

    testWidgets('renders ListTile with proper title', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(ListTile), findsOneWidget);

      expect(
        find.descendant(
          of: find.byType(ListTile),
          matching: find.text(pokemonName.asPokemonName()),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'navigates to PokemonDetailsPage '
        'when onTap is called', (tester) async {
      await tester.pumpApp(buildSubject());

      final listTile = tester.widget<ListTile>(
        find.byType(ListTile),
      );
      listTile.onTap!();

      verify(
        () => navigator.push<void>(any(that: isRoute<void>())),
      ).called(1);
    });
  });

  group('NoPokemonsFound', () {
    testWidgets('renders proper info text', (tester) async {
      await tester.pumpApp(
        const NoPokemonsFound(),
      );

      expect(find.byType(Text), findsOneWidget);

      expect(
        find.text(l10n.noPokemonsFound),
        findsOneWidget,
      );
    });
  });
}
