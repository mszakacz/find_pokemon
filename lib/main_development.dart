import 'package:flutter/material.dart';
import 'package:pokemon/app/app.dart';
import 'package:pokemon/bootstrap.dart';
import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pokemonsApiClient = PokemonsApiClient();

  final sharedPreferences = await SharedPreferences.getInstance();

  final pokemonsRepository = PokemonsRepository(
    pokemonsApiClient: pokemonsApiClient,
    sharedPreferences: sharedPreferences,
  );

  await bootstrap(
    () => App(
      pokemonsRepository: pokemonsRepository,
    ),
  );
}
