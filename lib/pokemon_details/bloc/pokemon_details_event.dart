part of 'pokemon_details_bloc.dart';

@immutable
abstract class PokemonDetailsEvent extends Equatable {
  const PokemonDetailsEvent();
}

class FetchPokemonDetails extends PokemonDetailsEvent {
  const FetchPokemonDetails({
    required this.pokemonName,
  });
  final String pokemonName;

  @override
  List<Object?> get props => [
        pokemonName,
      ];
}

class AddToFavorite extends PokemonDetailsEvent {
  const AddToFavorite({
    required this.isFavorite,
  });

  final bool isFavorite;

  @override
  List<Object?> get props => [
        isFavorite,
      ];
}
