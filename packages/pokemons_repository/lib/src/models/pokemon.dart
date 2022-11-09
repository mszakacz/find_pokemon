import 'package:equatable/equatable.dart';

import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

/// Pokemon model
class Pokemon extends Equatable {
  /// const constructor of the Pokemon model
  const Pokemon({
    required this.id,
    required this.name,
    required this.pictures,
    required this.stats,
    required this.weight,
    required this.height,
  });

  /// returns the instance of Pokemon from PokemonData
  factory Pokemon.fromData(PokemonData data) => Pokemon(
        id: data.id,
        name: data.name,
        pictures: picturesFromSprites(sprites: data.sprites),
        stats: pokemonStats(stats: data.stats),
        weight: data.weight,
        height: data.height,
      );

  /// pokemon id
  final int id;

  /// pokemon name
  final String name;

  /// pokemon pictures as List of urls
  final List<String> pictures;

  /// list of pokemon stats
  final List<Stat> stats;

  /// The weight of this Pokémon in hectograms.
  final int weight;

  /// The height of this Pokémon in decimetres
  final int height;

  @override
  List<Object> get props {
    return [
      id,
      name,
      pictures,
      stats,
      weight,
      height,
    ];
  }

  /// returns the empty instance of Pokemon
  static const empty = Pokemon(
    id: 0,
    name: '',
    pictures: <String>[],
    stats: <Stat>[],
    weight: 0,
    height: 0,
  );
}
