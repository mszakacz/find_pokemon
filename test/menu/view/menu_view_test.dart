import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/favorites/favorites.dart';
import 'package:pokemon/menu/menu.dart';
import 'package:pokemon/searching/searching.dart';

import '../../helpers/helpers.dart';

class MockMenuBloc extends MockBloc<MenuEvent, MenuState> implements MenuBloc {}

void main() {
  group('MenuPage', () {
    testWidgets('renders MenuView', (tester) async {
      await tester.pumpApp(
        const MenuPage(),
      );

      expect(find.byType(MenuView), findsOneWidget);
    });
  });

  group('HomeView', () {
    late MockNavigator navigator;
    late MenuBloc bloc;

    setUp(() {
      navigator = MockNavigator();
      when(() => navigator.push<void>(any())).thenAnswer((_) async {});

      bloc = MockMenuBloc();
      when(() => bloc.state).thenReturn(const MenuState(selectedIndex: 0));
    });

    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: bloc,
          child: const MenuView(),
        ),
      );
    }

    testWidgets(
      'renders SearchingPage '
      'when tab selectedIndex is 0',
      (tester) async {
        when(() => bloc.state).thenReturn(const MenuState(selectedIndex: 0));

        await tester.pumpApp(
          buildSubject(),
        );

        expect(find.byType(SearchingPage), findsOneWidget);
      },
    );

    testWidgets(
      'renders FavoritesPage '
      'when tab selectedIndex is 1',
      (tester) async {
        when(() => bloc.state).thenReturn(const MenuState(selectedIndex: 1));

        await tester.pumpApp(
          buildSubject(),
        );

        expect(find.byType(FavoritesPage), findsOneWidget);
      },
    );

    testWidgets(
      'calls ChangeMenuIndex to 0 on MenuBloc '
      'when Search navigation button is pressed',
      (tester) async {
        await tester.pumpApp(
          buildSubject(),
        );

        await tester.tap(find.byIcon(Icons.search_outlined));

        verify(() => bloc.add(const ChangeMenuIndex(index: 0))).called(1);
      },
    );

    testWidgets(
      'calls ChangeMenuIndex to 1 on MenuBloc '
      'when Favorite navigation button is pressed',
      (tester) async {
        await tester.pumpApp(
          buildSubject(),
        );

        await tester.tap(find.byIcon(Icons.favorite_outline));

        verify(() => bloc.add(const ChangeMenuIndex(index: 1))).called(1);
      },
    );
  });
}
