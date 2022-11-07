import 'package:json_annotation/json_annotation.dart';

part 'sprites_data.g.dart';

@JsonSerializable(createToJson: false)

/// Sprites Data
class SpritesData {
  /// const constructor of the Pokemon SpritesData model
  const SpritesData({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  /// it returns SpritesData from json
  factory SpritesData.fromJson(Map<String, dynamic> json) =>
      _$SpritesDataFromJson(json);

  /// back default sprite [String] as url to png
  @JsonKey(name: 'back_default')
  final String? backDefault;

  /// back female sprite [String] as url to png
  @JsonKey(name: 'back_female')
  final String? backFemale;

  /// back female shiny [String] as url to png
  @JsonKey(name: 'back_shiny')
  final String? backShiny;

  /// back shiny female sprite [String] as url to png
  @JsonKey(name: 'back_shiny_female')
  final String? backShinyFemale;

  /// front default sprite [String] as url to png
  @JsonKey(name: 'front_default')
  final String? frontDefault;

  /// front female sprite [String] as url to png
  @JsonKey(name: 'front_female')
  final String? frontFemale;

  /// front shiny sprite [String] as url to png
  @JsonKey(name: 'front_shiny')
  final String? frontShiny;

  /// front shiny female sprite [String] as url to png
  @JsonKey(name: 'front_shiny_female')
  final String? frontShinyFemale;
}
