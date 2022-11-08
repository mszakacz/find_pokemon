// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonData _$PokemonDataFromJson(Map<String, dynamic> json) => PokemonData(
      id: json['id'] as int,
      name: json['name'] as String,
      sprites: SpritesData.fromJson(json['sprites'] as Map<String, dynamic>),
      stats: (json['stats'] as List<dynamic>)
          .map(
            (dynamic e) => PokemonStatData.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      weight: json['weight'] as int,
      height: json['height'] as int,
    );
