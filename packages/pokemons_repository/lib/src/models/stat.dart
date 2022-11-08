import 'package:equatable/equatable.dart';
import 'package:pokemons_api/pokemons_api.dart';

/// Pokemon Stat
class Stat extends Equatable {
  /// const constructor of the Stat model
  const Stat({
    required this.value,
    required this.effort,
    required this.name,
  });

  /// it returns Stat from PokemonStatData
  factory Stat.fromData(PokemonStatData data) => Stat(
        value: data.value,
        effort: data.effort,
        name: data.stat.name,
      );

  /// stat base value
  final int value;

  /// stat effort
  final int effort;

  /// stat name
  final String name;

  @override
  List<Object> get props => [
        value,
        effort,
        name,
      ];
}
