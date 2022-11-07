// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_stat_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonStatData _$PokemonStatDataFromJson(Map<String, dynamic> json) =>
    PokemonStatData(
      value: json['base_stat'] as int,
      effort: json['effort'] as int,
      stat: StatData.fromJson(json['stat'] as Map<String, dynamic>),
    );
