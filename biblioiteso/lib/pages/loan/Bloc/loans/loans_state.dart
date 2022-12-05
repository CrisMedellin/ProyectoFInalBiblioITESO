part of 'loans_bloc.dart';

@immutable
abstract class LoansState {
  final int loansCount;
  final String loansList; //Arreglo de Objetos
  final String bookToReturn;
  /**
   * {
   * name: String
   * lastName: String
   * expedient: String
   * dateToReturn: DateTime
   * }
   */

  const LoansState({
    this.loansCount = 0, 
    this.loansList = '[]',
    this.bookToReturn = '',
  });

}

class LoansInitialState extends LoansState {
  const LoansInitialState():super(
    loansCount : 1,
    loansList : '[{"name": "Cristian Medellin","expediente": "727853","dateToReturn": "2022-12-17","title": "El hombre más rico de babilonia"}]',
  );
}

class LoansUpdateState extends LoansState {
  const LoansUpdateState({
    required int loansCount,
    required String loansList
    
  }):super(
    loansCount : loansCount,
    loansList : loansList
  );
}