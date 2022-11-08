import 'package:pokemon/app/app.dart';
import 'package:pokemon/bootstrap.dart';
import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

Future<void> main() async {
  final pokemonsApiClient = PokemonsApiClient();

  final pokemonsRepository = PokemonsRepository(
    pokemonsApiClient: pokemonsApiClient,
  );

  final pokemon = await pokemonsRepository.getPokemon(name: 'ditto');
  print('pokemon name: ${pokemon.name}');

  await bootstrap(
    () => const App(),
  );
}
