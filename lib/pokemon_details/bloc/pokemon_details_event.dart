part of 'pokemon_details_bloc.dart';

@immutable
abstract class PokemonDetailsEvent {
  const PokemonDetailsEvent();
}

class FetchPokemonDetails extends PokemonDetailsEvent {
  const FetchPokemonDetails({
    required this.pokemonName,
  });
  final String pokemonName;
}

class AddToFavorite extends PokemonDetailsEvent {
  const AddToFavorite({
    required this.isFavorite,
  });

  final bool isFavorite;
}
