import 'package:flutter/material.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
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
    if (pokemons.isEmpty) {
      return const NoPokemonsFound();
    }

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        final pokemon = pokemons[index];
        return SearchingListTile(
          pokemonName: pokemon,
          key: ValueKey('SearchingListTile-$pokemon'),
        );
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

class SearchingListTile extends StatelessWidget {
  const SearchingListTile({
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
        Navigator.of(context).push(
          PokemonDetailsPage.route(
            pokemonName: pokemonName,
          ),
        );
      },
    );
  }
}

class NoPokemonsFound extends StatelessWidget {
  const NoPokemonsFound({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Text(
          l10n.noPokemonsFound,
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
