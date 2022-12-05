part of 'loans_bloc.dart';

@immutable
abstract class LoansEvent {}

class GetLoansEvent extends LoansEvent{
  GetLoansEvent();
}

class UpdateLoansEvent extends LoansEvent{
  UpdateLoansEvent();
}

