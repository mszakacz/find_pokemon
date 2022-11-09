import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/favorites/favorites.dart';
import 'package:pokemon/widgets/widgets.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({
    super.key,
    required this.pokemons,
  });

  final List<String> pokemons;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) {
        context.read<FavoritesBloc>().add(
              ReorderFavorites(
                oldIndex: oldIndex,
                newIndex: newIndex,
              ),
            );
      },
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return PokemonListTile(
          key: ValueKey(pokemon),
          pokemonName: pokemon,
        );
      },
    );
  }
}
