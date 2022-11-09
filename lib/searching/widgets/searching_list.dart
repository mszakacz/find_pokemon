import 'package:flutter/material.dart';
import 'package:pokemon/theme/theme.dart';
import 'package:pokemon/utils/utils.dart';

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
        return _ListItem(pokemonName: pokemons[index]);
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

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.pokemonName,
  });

  final String pokemonName;

  @override
  Widget build(BuildContext context) {
    final displayName = pokemonName.asPokemonName();
    return ListTile(
      title: Text(
        displayName,
        style: Theme.of(context).textTheme.headline3,
      ),
      tileColor: AppColors.dark,
      textColor: AppColors.white,
    );
  }
}
