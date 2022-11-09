import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required PokemonsRepository pokemonsRepository,
  })  : _pokemonsRepository = pokemonsRepository,
        super(
          const FavoritesState(
            pokemons: <String>[],
            status: FavoritesStatus.loading,
          ),
        ) {
    on<FetchFavorites>(_onFetchFavorites);
    on<ReorderFavorites>(_onReorderFavorites);
  }

  final PokemonsRepository _pokemonsRepository;

  void _onFetchFavorites(
    FavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) {
    emit(
      state.copyWith(
        status: FavoritesStatus.loading,
      ),
    );

    try {
      final pokemons = _pokemonsRepository.getFavorites();
      emit(
        state.copyWith(
          pokemons: pokemons,
          status: FavoritesStatus.display,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: FavoritesStatus.error,
        ),
      );
    }
  }

  Future<void> _onReorderFavorites(
    ReorderFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final oldIndex = event.oldIndex;
    late int newIndex;

    final pokemons = state.pokemons;

    if (oldIndex < event.newIndex) {
      newIndex = event.newIndex - 1;
    } else {
      newIndex = event.newIndex;
    }

    final item = pokemons[oldIndex];

    pokemons
      ..removeAt(oldIndex)
      ..insert(newIndex, item);

    await _pokemonsRepository.reorderFavorites(
      favorites: pokemons,
    );

    add(
      const FetchFavorites(),
    );
  }
}
