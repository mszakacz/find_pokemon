part of 'favorites_bloc.dart';

enum FavoritesStatus {
  loading,
  error,
  display,
}

class FavoritesState extends Equatable {
  const FavoritesState({
    required this.pokemons,
    required this.status,
  });

  final List<String> pokemons;
  final FavoritesStatus status;

  @override
  List<Object> get props => [
        pokemons,
        status,
      ];

  FavoritesState copyWith({
    List<String>? pokemons,
    FavoritesStatus? status,
  }) {
    return FavoritesState(
      pokemons: pokemons ?? this.pokemons,
      status: status ?? this.status,
    );
  }
}
