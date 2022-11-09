import 'package:flutter/material.dart';
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
      actions: [
        Container(
          margin: const EdgeInsets.only(
            right: 20,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: AppColors.white,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
