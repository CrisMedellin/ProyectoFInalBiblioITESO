part of 'search_book_bloc.dart';

abstract class SearchBookEvent extends Equatable {
  const SearchBookEvent();

  @override
  List<dynamic> get props => [];
}

class SearchingBookEvent extends SearchBookEvent {
  final String titleSearch;
  final String selec;
  const SearchingBookEvent({required this.titleSearch, required this.selec});

  @override
  List<dynamic> get props => [titleSearch];
}
