import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemon/widgets/widgets.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({
    super.key,
    required this.pokemonName,
  });

  final String pokemonName;

  static Route<void> route({
    required String pokemonName,
  }) {
    return MaterialPageRoute(
      builder: (context) => PokemonDetailsPage(
        pokemonName: pokemonName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailsBloc(
        pokemonsRepository: context.read<PokemonsRepository>(),
      )..add(
          FetchPokemonDetails(pokemonName: pokemonName),
        ),
      child: const Scaffold(
        appBar: PokemonDetailsAppBar(),
        body: _PokemonDetailsView(),
      ),
    );
  }
}

class _PokemonDetailsView extends StatelessWidget {
  const _PokemonDetailsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
      builder: (context, state) {
        switch (state.status) {
          case PokemonDetailsStatus.loading:
            return const Loading();

          case PokemonDetailsStatus.error:
            return const PokemonErrorView();

          case PokemonDetailsStatus.display:
            return PokemonCard(
              pokemon: state.pokemon,
            );
        }
      },
    );
  }
}
