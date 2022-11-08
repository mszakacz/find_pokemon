import 'package:pokemons_api/pokemons_api.dart';

/// returns the list of pokemon pictures url
List<String> picturesFromSprites({
  required SpritesData sprites,
}) {
  final nullablePictures = <String?>[
    sprites.frontDefault,
    sprites.frontFemale,
    sprites.frontShiny,
    sprites.frontShinyFemale,
    sprites.backDefault,
    sprites.backFemale,
    sprites.backShiny,
    sprites.backShinyFemale,
  ];

  return nullablePictures.whereType<String>().toList();
}
