import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemon/theme/theme.dart';

class PokemonDetailsAppBar extends StatelessWidget with PreferredSizeWidget {
  const PokemonDetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(
        color: AppColors.white,
      ),
      leadingWidth: 80,
      actions: const [
        _FavoriteIcon(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FavoriteIcon extends StatelessWidget {
  const _FavoriteIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
      ),
      child: BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
        builder: (context, state) {
          final isFavorite = state.isFavorite;

          return IconButton(
            onPressed: () {
              context.read<PokemonDetailsBloc>().add(
                    AddToFavorite(
                      isFavorite: !isFavorite,
                    ),
                  );
            },
            icon: isFavorite
                ? const Icon(
                    Icons.favorite,
                    color: AppColors.red,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    color: AppColors.white,
                  ),
          );
        },
      ),
    );
  }
}
