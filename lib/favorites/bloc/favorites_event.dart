part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {
  const FavoritesEvent();
}

class FetchFavorites extends FavoritesEvent {
  const FetchFavorites();
}

class ReorderFavorites extends FavoritesEvent {
  const ReorderFavorites({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex;
  final int newIndex;
}
