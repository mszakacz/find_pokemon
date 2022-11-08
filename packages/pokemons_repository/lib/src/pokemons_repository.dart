import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

/// Flutter package that handles pokemon related requests
class PokemonsRepository {
  /// const constructor of the Pokemons Repository
  const PokemonsRepository({
    required PokemonsApiClient pokemonsApiClient,
  }) : _pokemonsApiClient = pokemonsApiClient;

  final PokemonsApiClient _pokemonsApiClient;

  /// returns the list of pokemons names matching given phrase
  Future<List<String>> searchPokemons({required String phrase}) async {
    final pokemons = await _pokemonsApiClient.searchPokemons(
      phrase: phrase,
    );
    return pokemons;
  }

  /// get pokemon by name
  Future<Pokemon> getPokemon({required String name}) async {
    final data = await _pokemonsApiClient.getPokemon(
      pokemonName: name,
    );
    return Pokemon.fromData(data);
  }

  /// returns the list of favorite pokemons
  Future<List<Pokemon>> getFavorites({required List<String> names}) async {
    final pokemons = <Pokemon>[];

    for (final name in names) {
      final pokemon = await getPokemon(name: name);
      pokemons.add(pokemon);
    }

    return pokemons;
  }
}
