import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/searching/searching.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

class SearchingPage extends StatelessWidget {
  const SearchingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchingBloc(
        pokemonsRepository: context.read<PokemonsRepository>(),
      )..add(
          const FetchPokemons(
            phrase: '',
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const SearchingInput(),
          toolbarHeight: 80,
        ),
        body: const SearchingBody(),
      ),
    );
  }
}
