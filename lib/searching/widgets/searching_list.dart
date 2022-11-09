import 'package:flutter/material.dart';

import 'package:pokemon/widgets/widgets.dart';

class SearchingList extends StatelessWidget {
  const SearchingList({
    super.key,
    required this.pokemons,
  });

  final List<String> pokemons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return PokemonListTile(pokemonName: pokemons[index]);
      },
      itemCount: pokemons.length,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 2,
        );
      },
    );
  }
}
