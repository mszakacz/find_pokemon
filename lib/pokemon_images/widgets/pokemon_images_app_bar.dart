import 'package:flutter/material.dart';
import 'package:pokemon/theme/theme.dart';
import 'package:pokemon/utils/utils.dart';

class PokemonImagesAppBar extends StatelessWidget with PreferredSizeWidget {
  const PokemonImagesAppBar({
    super.key,
    required this.pokemonName,
  });

  final String pokemonName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        pokemonName.asPokemonName(),
        style: Theme.of(context).textTheme.headline1,
      ),
      leading: const BackButton(
        color: AppColors.white,
      ),
      leadingWidth: 80,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
