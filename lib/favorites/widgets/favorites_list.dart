import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/favorites/favorites.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemon/theme/theme.dart';
import 'package:pokemon/utils/utils.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({
    super.key,
    required this.pokemons,
  });

  final List<String> pokemons;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ReorderableListView.builder(
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
          return FavoritesListTile(
            key: ValueKey(pokemon),
            pokemonName: pokemon,
          );
        },
      ),
    );
  }
}

class FavoritesListTile extends StatelessWidget {
  const FavoritesListTile({
    super.key,
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
      trailing: const Icon(
        Icons.drag_handle_outlined,
        color: AppColors.white,
      ),
      tileColor: AppColors.darkScaffold,
      textColor: AppColors.white,
      onTap: () {
        Navigator.of(context)
            .push(
          PokemonDetailsPage.route(
            pokemonName: pokemonName,
          ),
        )
            .whenComplete(() {
          context.read<FavoritesBloc>().add(
                const FetchFavorites(),
              );
        });
      },
    );
  }
}
