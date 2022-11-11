import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/searching/searching.dart';
import 'package:pokemon/utils/utils.dart';
import 'package:pokemon/widgets/widgets.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

class MockSearchingBloc extends MockBloc<SearchingEvent, SearchingState>
    implements SearchingBloc {}

class MockSnackbar extends Mock implements Snackbar {}

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

void main() {
  const pokemons = <String>['name1', 'name2', 'name3'];

  late SearchingBloc searchingBloc;
  late PokemonsRepository pokemonsRepository;
  late MockNavigator navigator;

  setUp(() {
    searchingBloc = MockSearchingBloc();
    pokemonsRepository = MockPokemonsRepository();
    navigator = MockNavigator();

    when(() => searchingBloc.state).thenReturn(
      const SearchingState(
        status: SearchingStatus.loading,
        results: <String>[],
      ),
    );
  });

  group('SearchingBody', () {
    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: searchingBloc,
          child: const SearchingBody(),
        ),
      );
    }

    testWidgets(
        'shows error snackbar '
        'when status changes to error', (tester) async {
      whenListen<SearchingState>(
        searchingBloc,
        Stream.fromIterable([
          const SearchingState(
            status: SearchingStatus.loading,
            results: <String>[],
          ),
          const SearchingState(
            status: SearchingStatus.error,
            results: <String>[],
          ),
        ]),
      );

      await tester.pumpApp(
        buildSubject(),
        pokemonsRepository: pokemonsRepository,
      );
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(SnackBar),
          matching: find.text(l10n.fetchingPokemonsFailed),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders Loading when status is loading', (tester) async {
      when(() => searchingBloc.state).thenReturn(
        const SearchingState(
          results: <String>[],
          status: SearchingStatus.loading,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(Loading), findsOneWidget);
    });

    testWidgets('renders ErrorView when status is error', (tester) async {
      when(() => searchingBloc.state).thenReturn(
        const SearchingState(
          results: <String>[],
          status: SearchingStatus.error,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('renders SearchingList when status is display', (tester) async {
      when(() => searchingBloc.state).thenReturn(
        const SearchingState(
          results: <String>[],
          status: SearchingStatus.display,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(SearchingList), findsOneWidget);
    });

    testWidgets(
        'renders SearchingList '
        'with proper pokemons', (tester) async {
      when(() => searchingBloc.state).thenReturn(
        const SearchingState(
          results: pokemons,
          status: SearchingStatus.display,
        ),
      );
      await tester.pumpApp(buildSubject());

      final searchingList = tester.widget<SearchingList>(
        find.byType(SearchingList),
      );

      expect(searchingList.pokemons, pokemons);
    });
  });
}
