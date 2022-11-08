import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokemons_api/pokemons_api.dart';

part 'pokemon_data.g.dart';

@JsonSerializable(createToJson: false)

/// Pokemon Data
class PokemonData extends Equatable {
  /// const constructor of the PokemonData model
  const PokemonData({
    required this.id,
    required this.name,
    required this.sprites,
    required this.stats,
    required this.weight,
    required this.height,
  });

  /// it returns PokemonData from json
  factory PokemonData.fromJson(Map<String, dynamic> json) =>
      _$PokemonDataFromJson(json);

  /// pokemon id [int]
  final int id;

  /// pokemon name [String]
  final String name;

  /// pokemon sprites [SpritesData]
  final SpritesData sprites;

  /// list of pokemon stats
  final List<PokemonStatData> stats;

  /// The weight of this Pokémon in hectograms.
  final int weight;

  /// The height of this Pokémon in decimetres
  final int height;

  @override
  List<Object> get props {
    return [
      id,
      name,
      sprites,
      stats,
      weight,
      height,
    ];
  }
}
