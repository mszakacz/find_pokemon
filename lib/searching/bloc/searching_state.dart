part of 'searching_bloc.dart';

enum SearchingStatus {
  loading,
  error,
  display,
}

class SearchingState extends Equatable {
  const SearchingState({
    required this.status,
    required this.results,
  });

  final SearchingStatus status;
  final List<String> results;

  @override
  List<Object> get props => [
        status,
        results,
      ];

  SearchingState copyWith({
    SearchingStatus? status,
    List<String>? results,
  }) {
    return SearchingState(
      status: status ?? this.status,
      results: results ?? this.results,
    );
  }
}
