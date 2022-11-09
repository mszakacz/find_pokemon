import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Flutter package that handles pokemon related requests
class PokemonsRepository {
  /// const constructor of the Pokemons Repository
  const PokemonsRepository({
    required PokemonsApiClient pokemonsApiClient,
    required SharedPreferences sharedPreferences,
  })  : _pokemonsApiClient = pokemonsApiClient,
        _sharedPreferences = sharedPreferences;

  final PokemonsApiClient _pokemonsApiClient;
  final SharedPreferences _sharedPreferences;

  static const _favoritesKey = 'favorites';

  /// returns the list of pokemons names matching given phrase
  Future<List<String>> searchPokemons({
    required String phrase,
  }) async {
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

  /// add pokemon to favorites
  Future<void> addPokemonToFavorites({required String pokemonName}) async {
    final favorites = getFavorites();
    if (!favorites.contains(pokemonName)) {
      favorites.add(pokemonName);
    }
    await _saveFavorites(pokemons: favorites);
  }

  /// remove pokemon from favorites
  Future<void> removePokemonFromFavorites({required String pokemonName}) async {
    final favorites = getFavorites();
    if (favorites.contains(pokemonName)) {
      favorites.remove(pokemonName);
    }
    await _saveFavorites(pokemons: favorites);
  }

  /// save list of favorite pokemons
  Future<void> _saveFavorites({required List<String> pokemons}) async {
    await _sharedPreferences.setStringList(_favoritesKey, pokemons);
  }

  /// get the list of favorite pokemons names from Device Memory
  List<String> getFavorites() {
    return _sharedPreferences.getStringList(_favoritesKey) ?? <String>[];
  }

  /// is pokemon saved as favorite [bool]
  bool isFavorite({required String pokemonName}) {
    final favorites = getFavorites();
    return favorites.contains(pokemonName);
  }

  /// reorder list of favorite pokemons
  Future<void> reorderFavorites({required List<String> favorites}) async {
    await _saveFavorites(pokemons: favorites);
  }
}
