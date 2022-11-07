import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_stat_data.g.dart';

@JsonSerializable(createToJson: false)

/// Pokemon Stat Data
class PokemonStatData extends Equatable {
  /// const constructor of the PokemonStatData model
  const PokemonStatData({
    required this.value,
    required this.effort,
    required this.stat,
  });

  /// it returns PokemonStatData from json
  factory PokemonStatData.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatDataFromJson(json);

  /// stat base value
  @JsonKey(name: 'base_stat')
  final int value;

  /// stat effort
  @JsonKey(name: 'effort')
  final int effort;

  /// stat
  @JsonKey(name: 'stat')
  final StatData stat;

  @override
  List<Object> get props => [
        value,
        effort,
        stat,
      ];
}
