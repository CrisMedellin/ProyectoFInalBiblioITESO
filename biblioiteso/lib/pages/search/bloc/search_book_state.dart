part of 'search_book_bloc.dart';

@immutable
abstract class SearchBookState extends Equatable {
  const SearchBookState();

  @override
  List<Object?> get props => [];
}

class SearchBookInitialState extends SearchBookState {}

class SearchingState extends SearchBookState {}

class ErrorInSearchingState extends SearchBookState {
  final String errMess;
  const ErrorInSearchingState({required this.errMess});

  @override
  List<Object?> get props => [];
}

class FoundInSearchState extends SearchBookState {
  final List<dynamic> findBooks;
  const FoundInSearchState({required this.findBooks});

  @override
  List<Object?> get props => [findBooks];
}
