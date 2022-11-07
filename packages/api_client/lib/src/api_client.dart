import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:http/http.dart' as http;

/// Exception thrown when getPokemon method fails.
class GetPokemonFailure implements Exception {}

/// Exception thrown when getPokemonsByPhrase method fails.
class GetPokemonsByPhraseFailure implements Exception {}

/// Exception thrown when PokemonData from json fails.
class PokemonDeserializationFailure implements Exception {}

/// Api CLient
class ApiClient {
  /// {@macro location_api_client}
  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const String _apiBaseUrl = 'pokeapi.co';

  static const String _method = '/api/v2/pokemon/';

  final _headers = {
    'Accept': 'application/json',
    'Content-type': 'application/json',
  };

  /// get pokemon [PokemonData] by name
  Future<PokemonData> getPokemon({required String pokemonName}) async {
    // final queryParameters = {
    //   'name': pokemonName,
    // };

    final uri = Uri.http(
      _apiBaseUrl,
      _method + pokemonName,
      // queryParameters,
    );

    try {
      final response = await _httpClient.get(
        uri,
        headers: _headers,
      );

      final dynamic json = jsonDecode(response.body);

      try {
        final pokemon = PokemonData.fromJson(json as Map<String, dynamic>);
        return pokemon;
      } catch (_) {
        throw PokemonDeserializationFailure();
      }
    } catch (_) {
      throw GetPokemonFailure();
    }
  }

  /// get list of pokemons which name matching given phrase
  Future<List<PokemonData>> getPokemonsByPhrase({
    required String phrase,
  }) async {
    const suggestionsLimit = 10;

    final queryParameters = {
      'limit': '100000',
      'offset': '0',
    };

    final uri = Uri.http(
      _apiBaseUrl,
      '/api/v2/pokemon',
      queryParameters,
    );

    try {
      final response = await _httpClient.get(
        uri,
        headers: _headers,
      );

      final pokemons = <PokemonData>[];

      final dynamic jsonList =
          (jsonDecode(response.body) as Map<String, dynamic>)['results'];

      for (final json in jsonList) {
        final searchingResult =
            PokemonSearchingResult.fromJson(json as Map<String, dynamic>);
        final pokemonName = searchingResult.name;
        if (pokemonName.contains(phrase)) {
          final pokemon = await getPokemon(
            pokemonName: pokemonName,
          );
          pokemons.add(pokemon);
          if (pokemons.length > suggestionsLimit) {
            break;
          }
        }
      }
      return pokemons;
    } catch (_) {
      throw GetPokemonsByPhraseFailure();
    }
  }
}
