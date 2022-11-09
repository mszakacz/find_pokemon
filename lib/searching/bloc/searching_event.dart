part of 'searching_bloc.dart';

@immutable
abstract class SearchingEvent extends Equatable {
  const SearchingEvent();
}

class FetchPokemons extends SearchingEvent {
  const FetchPokemons({
    required this.phrase,
  });

  final String phrase;

  @override
  List<Object?> get props => [
        phrase,
      ];
}
