import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';
import 'package:pokemons_repository/src/service/pokemon_stats.dart';

/// Pokemon model
class Pokemon {
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
        stats: pokemonsStats(stats: data.stats),
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

  /// pokemon weight
  final int weight;

  /// The height of this Pokémon in decimetres
  final int height;
}
