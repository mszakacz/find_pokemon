import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/app/app.dart';
import 'package:pokemon/menu/menu.dart';
import 'package:pokemon/theme/app_theme.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late PokemonsRepository pokemonsRepository;

  setUp(() {
    pokemonsRepository = MockPokemonsRepository();
  });

  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(pokemonsRepository: pokemonsRepository),
      );

      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    testWidgets('renders MaterialApp with correct themes', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: pokemonsRepository,
          child: const AppView(),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, equals(AppTheme.dark));
    });

    testWidgets('renders MenuView', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: pokemonsRepository,
          child: const AppView(),
        ),
      );

      expect(find.byType(MenuView), findsOneWidget);
    });
  });
}
