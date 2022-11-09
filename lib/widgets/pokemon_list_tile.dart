import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/favorites/favorites.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemon/theme/theme.dart';
import 'package:pokemon/utils/utils.dart';

class PokemonListTile extends StatelessWidget {
  const PokemonListTile({
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
