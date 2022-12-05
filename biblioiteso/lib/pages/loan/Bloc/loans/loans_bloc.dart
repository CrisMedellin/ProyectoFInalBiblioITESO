import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
part 'loans_event.dart';
part 'loans_state.dart';

class LoansBloc extends Bloc<LoansEvent, LoansState> {
  LoansBloc() : super(LoansInitialState()) {
    on<GetLoansEvent>((event, emit) async {
      var loans = [];
      await FirebaseFirestore.instance
          .collection('user')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          DocumentSnapshot documentSnapshot = doc;
          Map<String, dynamic> userInfo =
              documentSnapshot.data() as Map<String, dynamic>;
          print(userInfo['expediente']);
          if (userInfo['loans'] != null) {
            // if (doc['loans'].length > 0) {
            for (var book in userInfo['loans']) {
              var newLoan = {
                'nombre': userInfo['nombre'],
                'expediente': userInfo['expediente'],
                'dateToReturn': book['dateToReturn'],
                'title': book['volumeInfo']['title'],
              };
              loans.add(newLoan);
            }
            // }
          }
        });
      });
      emit(LoansUpdateState(
          loansCount: loans.length, loansList: jsonEncode(loans)));
    });
  }
}
