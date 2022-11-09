part of 'pokemon_details_bloc.dart';

enum PokemonDetailsStatus {
  loading,
  error,
  display,
}

class PokemonDetailsState extends Equatable {
  const PokemonDetailsState({
    required this.status,
    required this.pokemon,
    required this.isFavorite,
  });
  final PokemonDetailsStatus status;
  final Pokemon pokemon;
  final bool isFavorite;

  @override
  List<Object> get props => [
        status,
        pokemon,
        isFavorite,
      ];

  PokemonDetailsState copyWith({
    PokemonDetailsStatus? status,
    Pokemon? pokemon,
    bool? isFavorite,
  }) {
    return PokemonDetailsState(
      status: status ?? this.status,
      pokemon: pokemon ?? this.pokemon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
