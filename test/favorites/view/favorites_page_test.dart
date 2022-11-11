import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/favorites/favorites.dart';
import 'package:pokemon/widgets/widgets.dart';

import '../../helpers/helpers.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  const favorites = <String>['name1', 'name2'];

  late FavoritesBloc favoritesBloc;

  setUp(() {
    favoritesBloc = MockFavoritesBloc();
    when(() => favoritesBloc.state).thenReturn(
      const FavoritesState(
        status: FavoritesStatus.loading,
        pokemons: favorites,
      ),
    );
  });

  group('FavoritesPage', () {
    Widget buildSubject() {
      return BlocProvider.value(
        value: favoritesBloc,
        child: const FavoritesPage(),
      );
    }

    testWidgets('renders AppBar', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('renders FavoritesBody', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(FavoritesBody), findsOneWidget);
    });
  });

  group('FavoritesBody', () {
    Widget buildSubject() {
      return BlocProvider.value(
        value: favoritesBloc,
        child: const FavoritesBody(),
      );
    }

    testWidgets('renders Loading when status is loading', (tester) async {
      when(() => favoritesBloc.state).thenReturn(
        const FavoritesState(
          pokemons: <String>[],
          status: FavoritesStatus.loading,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(Loading), findsOneWidget);
    });

    testWidgets('renders ErrorView when status is error', (tester) async {
      when(() => favoritesBloc.state).thenReturn(
        const FavoritesState(
          pokemons: <String>[],
          status: FavoritesStatus.error,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('renders FavoritesList when status is display', (tester) async {
      when(() => favoritesBloc.state).thenReturn(
        const FavoritesState(
          pokemons: favorites,
          status: FavoritesStatus.display,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(FavoritesList), findsOneWidget);
    });

    testWidgets(
        'renders FavoritesList '
        'with proper pokemons', (tester) async {
      when(() => favoritesBloc.state).thenReturn(
        const FavoritesState(
          pokemons: favorites,
          status: FavoritesStatus.display,
        ),
      );
      await tester.pumpApp(buildSubject());

      final favoritesList = tester.widget<FavoritesList>(
        find.byType(FavoritesList),
      );

      expect(favoritesList.pokemons, favorites);
    });
  });
}
