import 'package:pokemons_api/pokemons_api.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

/// returns the list of pokemon stats [List]<[Stat]>
List<Stat> pokemonsStats({
  required List<PokemonStatData> stats,
}) {
  final pokemonStats = <Stat>[];
  for (final data in stats) {
    pokemonStats.add(
      Stat.fromData(
        data,
      ),
    );
  }
  return pokemonStats;
}
