import 'package:json_annotation/json_annotation.dart';

part 'pokemon_searching_result.g.dart';

@JsonSerializable(createToJson: false)

/// Pokemon Searching Result
class PokemonSearchingResult {
  /// const constructor of the PokemonSearchingResult model
  const PokemonSearchingResult({
    required this.name,
    required this.url,
  });

  /// it returns PokemonSearchingResult from json
  factory PokemonSearchingResult.fromJson(Map<String, dynamic> json) =>
      _$PokemonSearchingResultFromJson(json);

  /// pokemon name [String]
  final String name;

  /// url to pokemon data [String]
  final String url;
}
