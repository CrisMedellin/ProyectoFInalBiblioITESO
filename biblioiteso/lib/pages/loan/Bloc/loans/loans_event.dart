part of 'loans_bloc.dart';

@immutable
abstract class LoansEvent {}

class GetLoansEvent extends LoansEvent{
  GetLoansEvent();
}

class UpdateLoansEvent extends LoansEvent{
  UpdateLoansEvent();
}

class ReturnLoanEvent extends LoansEvent{
  final String bookToReturn;
  final String userID;
  ReturnLoanEvent({required this.bookToReturn, required this.userID});
}

class UpdateBookToReturnEvent extends LoansEvent{
  final String bookToReturn;
  UpdateBookToReturnEvent({required this.bookToReturn});
}