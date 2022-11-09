import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

part 'searching_event.dart';
part 'searching_state.dart';

class SearchingBloc extends Bloc<SearchingEvent, SearchingState> {
  SearchingBloc({
    required PokemonsRepository pokemonsRepository,
  })  : _pokemonsRepository = pokemonsRepository,
        super(
          const SearchingState(
            status: SearchingStatus.loading,
            results: <String>[],
          ),
        ) {
    on<FetchPokemons>(_onFetchPokemons);
  }

  final PokemonsRepository _pokemonsRepository;

  Future<void> _onFetchPokemons(
    FetchPokemons event,
    Emitter<SearchingState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SearchingStatus.loading,
      ),
    );

    try {
      final results = await _pokemonsRepository.searchPokemons(
        phrase: event.phrase,
      );

      emit(
        state.copyWith(
          results: results,
          status: SearchingStatus.display,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          results: <String>[],
          status: SearchingStatus.error,
        ),
      );
    }
  }
}
