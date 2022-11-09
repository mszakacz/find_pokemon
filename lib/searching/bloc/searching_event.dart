part of 'searching_bloc.dart';

@immutable
abstract class SearchingEvent {
  const SearchingEvent();
}

class FetchPokemons extends SearchingEvent {
  const FetchPokemons({
    required this.phrase,
  });

  final String phrase;
}
