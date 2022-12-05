import 'package:biblioiteso/pages/search/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'search_book_event.dart';
part 'search_book_state.dart';

class SearchBookBloc extends Bloc<SearchBookEvent, SearchBookState> {
  SearchBookState get estate => SearchBookInitialState();
  final RepoBook bookRep = RepoBook();

  SearchBookBloc() : super(SearchBookInitialState()) {
    on<SearchingBookEvent>(_searchBook);
  }

  Future<dynamic> _searchBook(SearchingBookEvent event, Emitter emit) async {
    emit(SearchingState());
    String titleBook = event.titleSearch;
    String selec = event.selec;
    List<dynamic> listB;

    try {
      listB = await bookRep.getLoanList(titleBook, selec);

      emit(FoundInSearchState(findBooks: listB));
    } catch (e) {
      emit(
        const ErrorInSearchingState(errMess: "sucedio un error en la busqueda"),
      );
    }
  }
}
