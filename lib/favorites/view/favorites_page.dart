import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/favorites/favorites.dart';
import 'package:pokemon/favorites/widgets/widgets.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemon/theme/app_colors.dart';
import 'package:pokemon/widgets/widgets.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(
        pokemonsRepository: context.read<PokemonsRepository>(),
      )..add(
          const FetchFavorites(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const _AppBarTitle(),
          backgroundColor: AppColors.darkBar,
          toolbarHeight: 80,
        ),
        body: const _FavoritesBody(),
      ),
    );
  }
}

class _FavoritesBody extends StatelessWidget {
  const _FavoritesBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        switch (state.status) {
          case FavoritesStatus.loading:
            return const Loading();

          case FavoritesStatus.error:
            return const ErrorView();

          case FavoritesStatus.display:
            return FavoritesList(
              pokemons: state.pokemons,
            );
        }
      },
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Text(
      l10n.favorites,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
