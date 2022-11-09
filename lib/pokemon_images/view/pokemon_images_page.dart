import 'package:flutter/material.dart';
import 'package:pokemon/pokemon_images/pokemon_images.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class PokemonImagesPage extends StatelessWidget {
  const PokemonImagesPage({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  static Route<void> route({
    required Pokemon pokemon,
  }) {
    return MaterialPageRoute(
      builder: (context) => PokemonImagesPage(
        pokemon: pokemon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PokemonImagesAppBar(
        pokemonName: pokemon.name,
      ),
      body: SafeArea(
        child: Center(
          child: ImagesSlider(
            pictures: pokemon.pictures,
          ),
        ),
      ),
    );
  }
}
