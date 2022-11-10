import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemon/menu/menu.dart';
import 'package:pokemon/theme/theme.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required PokemonsRepository pokemonsRepository})
      : _pokemonsRepository = pokemonsRepository;

  final PokemonsRepository _pokemonsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PokemonsRepository>.value(
      value: _pokemonsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.dark,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MenuPage(),
    );
  }
}
