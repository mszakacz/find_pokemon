import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  PokemonDetailsBloc({
    required PokemonsRepository pokemonsRepository,
  })  : _pokemonsRepository = pokemonsRepository,
        super(
          const PokemonDetailsState(
            status: PokemonDetailsStatus.loading,
            pokemon: Pokemon.empty,
            isFavorite: false,
          ),
        ) {
    on<FetchPokemonDetails>(_onFetchPokemonDetails);
  }

  final PokemonsRepository _pokemonsRepository;

  Future<void> _onFetchPokemonDetails(
    FetchPokemonDetails event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: PokemonDetailsStatus.loading,
        isFavorite: false,
      ),
    );
    try {
      final pokemon = await _pokemonsRepository.getPokemon(
        name: event.pokemonName,
      );
      emit(
        state.copyWith(
          status: PokemonDetailsStatus.display,
          pokemon: pokemon,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: PokemonDetailsStatus.error,
        ),
      );
    }
  }
}
