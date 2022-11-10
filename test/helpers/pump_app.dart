import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    PokemonsRepository? pokemonsRepository,
  }) {
    return pumpWidget(
      RepositoryProvider.value(
        value: pokemonsRepository ?? MockPokemonsRepository(),
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }

  Future<void> pumpRoute(
    Route<dynamic> route, {
    PokemonsRepository? pokemonsRepository,
  }) {
    return pumpApp(
      Navigator(onGenerateRoute: (_) => route),
      pokemonsRepository: pokemonsRepository,
    );
  }
}
