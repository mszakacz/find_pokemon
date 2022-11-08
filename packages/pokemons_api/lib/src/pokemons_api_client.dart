import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemons_api/pokemons_api.dart';

/// Exception thrown when getPokemon request fails.
class GetPokemonRequestFailure implements Exception {}

/// Exception thrown when searchPokemons request fails.
class SearchPokemonsRequestFailure implements Exception {}

/// Exception thrown when PokemonData from json fails.
class PokemonDeserializationFailure implements Exception {}

/// Exception thrown when PokemonSearchingResult from json fails.
class PokemonSearchingResultDeserializationFailure implements Exception {}

/// Pokemons Api CLient
class PokemonsApiClient {
  /// constructor of the Pokemons Api Client
  PokemonsApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const String _apiBaseUrl = 'pokeapi.co';

  static const String _method = '/api/v2/pokemon';

  /// get pokemon [PokemonData] by name
  Future<PokemonData> getPokemon({required String pokemonName}) async {
    final uri = Uri.https(
      _apiBaseUrl,
      '$_method/$pokemonName',
    );

    final response = await _httpClient.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw GetPokemonRequestFailure();
    }

    try {
      final dynamic json = jsonDecode(response.body);

      return PokemonData.fromJson(json as Map<String, dynamic>);
    } catch (_) {
      throw PokemonDeserializationFailure();
    }
  }

  /// get list of pokemons which name matching given phrase
  Future<List<String>> searchPokemons({
    required String phrase,
  }) async {
    final queryParameters = {
      'limit': '100000',
      'offset': '0',
    };

    final uri = Uri.https(
      _apiBaseUrl,
      _method,
      queryParameters,
    );

    final response = await _httpClient.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw SearchPokemonsRequestFailure();
    }

    final results = <PokemonSearchingResult>[];

    try {
      final dynamic jsonList =
          (jsonDecode(response.body) as Map<String, dynamic>)['results'];

      for (final json in jsonList) {
        final result = PokemonSearchingResult.fromJson(
          json as Map<String, dynamic>,
        );
        results.add(result);
      }

      return _filterResults(
        results: results,
        phrase: phrase,
      );
    } catch (_) {
      throw PokemonSearchingResultDeserializationFailure();
    }
  }

  List<String> _filterResults({
    required List<PokemonSearchingResult> results,
    required String phrase,
  }) {
    final matchingNames = <String>[];

    for (final result in results) {
      final name = result.name;
      if (name.contains(phrase)) {
        matchingNames.add(name);
      }
    }

    return matchingNames;
  }
}
