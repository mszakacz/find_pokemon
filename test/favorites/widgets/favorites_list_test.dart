import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/favorites/favorites.dart';
import 'package:pokemon/utils/utils.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  const mockFavorites = ['name1', 'name2', 'name3'];

  late PokemonsRepository pokemonsRepository;
  late MockNavigator navigator;
  late FavoritesBloc favoritesBloc;

  setUpAll(() {
    favoritesBloc = MockFavoritesBloc();
    when(() => favoritesBloc.state).thenReturn(
      const FavoritesState(
        status: FavoritesStatus.display,
        pokemons: mockFavorites,
      ),
    );
  });

  group('FavoritesList', () {
    setUp(() {
      pokemonsRepository = MockPokemonsRepository();
      when(pokemonsRepository.getFavorites).thenAnswer((_) => mockFavorites);
    });

    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: favoritesBloc,
          child: const FavoritesList(
            pokemons: mockFavorites,
          ),
        ),
      );
    }

    testWidgets(
        'renders NoFavoritePokemons '
        'when pokemons is empty list', (tester) async {
      await tester.pumpApp(
        const FavoritesList(
          pokemons: [],
        ),
        pokemonsRepository: pokemonsRepository,
      );

      expect(find.byType(NoFavoritePokemons), findsOneWidget);
    });

    testWidgets(
        'renders ReorderableListView '
        'when pokemons is not empty list', (tester) async {
      await tester.pumpApp(
        const FavoritesList(
          pokemons: mockFavorites,
        ),
        pokemonsRepository: pokemonsRepository,
      );

      expect(find.byType(ReorderableListView), findsOneWidget);
    });

    testWidgets(
        'renders FavoritesListTile '
        'as many times as pokemons list length', (tester) async {
      await tester.pumpApp(
        const FavoritesList(
          pokemons: mockFavorites,
        ),
        pokemonsRepository: pokemonsRepository,
      );

      expect(
        find.byType(FavoritesListTile),
        findsNWidgets(mockFavorites.length),
      );
    });

    testWidgets(
        'renders first FavoritesListTile '
        'with correct pokemonName', (tester) async {
      await tester.pumpApp(
        const FavoritesList(
          pokemons: mockFavorites,
        ),
        pokemonsRepository: pokemonsRepository,
      );

      final firstName = mockFavorites[0];

      final favoriteListTile = tester.widget<FavoritesListTile>(
        find.byKey(ValueKey(firstName)),
      );

      expect(
        favoriteListTile.pokemonName,
        firstName,
      );
    });

    testWidgets(
        'renders all FavoritesListTile s '
        'with correct pokemonName', (tester) async {
      await tester.pumpApp(
        const FavoritesList(
          pokemons: mockFavorites,
        ),
        pokemonsRepository: pokemonsRepository,
      );

      for (final name in mockFavorites) {
        final favoriteListTile = tester.widget<FavoritesListTile>(
          find.byKey(ValueKey(name)),
        );
        expect(
          favoriteListTile.pokemonName,
          name,
        );
      }
    });

    testWidgets(
        'calls ReorderFavorites on FavoritesBloc '
        'when onReorder is called', (tester) async {
      await tester.pumpApp(
        buildSubject(),
      );

      const oldIndex = 0;
      const newIndex = 1;

      final reorderableListView = tester.widget<ReorderableListView>(
        find.byType(ReorderableListView),
      );
      reorderableListView.onReorder(
        oldIndex,
        newIndex,
      );

      verify(
        () => favoritesBloc.add(
          const ReorderFavorites(
            oldIndex: oldIndex,
            newIndex: newIndex,
          ),
        ),
      ).called(1);
    });
  });

  group('FavoritesListTile', () {
    const pokemonName = 'name';
    navigator = MockNavigator();

    when(() => navigator.push<void>(any())).thenAnswer((_) async {});

    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: favoritesBloc,
          child: const FavoritesListTile(
            pokemonName: pokemonName,
          ),
        ),
      );
    }

    testWidgets('renders ListTile', (tester) async {
      await tester.pumpApp(
        const FavoritesListTile(
          pokemonName: pokemonName,
        ),
      );

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
      await tester.pumpApp(
        buildSubject(),
      );

      final listTile = tester.widget<ListTile>(
        find.byType(ListTile),
      );
      listTile.onTap!();

      verify(
        () => navigator.push<void>(any(that: isRoute<void>())),
      ).called(1);
    });
  });

  group('NoFavoritePokemons', () {
    testWidgets('renders proper info text', (tester) async {
      await tester.pumpApp(
        const NoFavoritePokemons(),
      );

      expect(find.byType(Text), findsOneWidget);

      expect(
        find.text(l10n.noFavoritePokemons),
        findsOneWidget,
      );
    });
  });
}
