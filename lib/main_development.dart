import 'package:pokemon/app/app.dart';
import 'package:pokemon/bootstrap.dart';

import 'package:pokemons_api/pokemons_api.dart';

Future<void> main() async {
  final pokemonsApiClient = PokemonsApiClient();

  final pokemonName = await pokemonsApiClient.searchPokemons(phrase: 'ditto');
  print('pokemon name: ${pokemonName}');

  await bootstrap(
    () => const App(),
  );
}
