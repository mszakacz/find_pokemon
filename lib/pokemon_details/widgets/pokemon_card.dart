import 'package:flutter/material.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemon/pokemon_images/pokemon_images.dart';
import 'package:pokemon/theme/app_colors.dart';
import 'package:pokemon/utils/utils.dart';
import 'package:pokemon/widgets/widgets.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),

          // Avatar
          _Avatar(pokemon: pokemon),
          const SizedBox(height: 20),

          // Name
          _PokemonName(name: pokemon.name),
          const SizedBox(height: 20),

          // Stats
          _Stats(stats: pokemon.stats),

          const SizedBox(height: 20),

          // Pokemon Size
          _PokemonSize(pokemon: pokemon),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final pictures = pokemon.pictures;
    final screenWidth = MediaQuery.of(context).size.width;

    final size = 0.7 * screenWidth;

    const borderRadius = 50.0;

    final mainPicture = pictures.isEmpty ? '' : pictures.first;

    return SizedBox(
      width: screenWidth,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PokemonImagesPage.route(
                pokemon: pokemon,
              ),
            );
          },
          child: CachedImg(
            pictureUrl: mainPicture,
            borderRadius: borderRadius,
            height: size,
            width: size,
          ),
        ),
      ),
    );
  }
}

class _PokemonName extends StatelessWidget {
  const _PokemonName({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name.asPokemonName(),
      style: Theme.of(context).textTheme.headline1,
      textAlign: TextAlign.center,
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({
    required this.stats,
  });

  final List<Stat> stats;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (final stat in stats) {
      children.add(
        _Stat(
          stat: stat,
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.dark,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.stat,
  });

  final Stat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 30,
        top: 5,
        bottom: 5,
      ),
      child: Row(
        children: [
          Text(
            stat.name.toUpperCase(),
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: AppColors.gold,
                ),
          ),
          Text(
            ': ',
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            '${stat.value}',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: AppColors.lightBlue,
                ),
          ),
        ],
      ),
    );
  }
}

class _PokemonSize extends StatelessWidget {
  const _PokemonSize({
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    // pokemon height in cm
    final height = pokemon.height * 10;

    // pokemon weight in kg
    final weight = (pokemon.weight / 10).round();

    final l10n = context.l10n;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.dark,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Pokemon Height
            _PokemonSizeProperty(
              label: l10n.height,
              value: height,
              unit: l10n.cm,
            ),

            // Pokemon Weight
            _PokemonSizeProperty(
              label: l10n.weight,
              value: weight,
              unit: l10n.kg,
            ),
          ],
        ),
      ),
    );
  }
}

class _PokemonSizeProperty extends StatelessWidget {
  const _PokemonSizeProperty({
    required this.value,
    required this.unit,
    required this.label,
  });

  /// value in SI unit
  final int value;

  final String unit;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                color: AppColors.green,
              ),
        ),
        Text(
          '$value $unit',
        ),
      ],
    );
  }
}
