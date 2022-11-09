part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class FetchFavorites extends FavoritesEvent {
  const FetchFavorites();

  @override
  List<Object?> get props => [];
}

class ReorderFavorites extends FavoritesEvent {
  const ReorderFavorites({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex;
  final int newIndex;

  @override
  List<Object?> get props => [
        oldIndex,
        newIndex,
      ];
}
