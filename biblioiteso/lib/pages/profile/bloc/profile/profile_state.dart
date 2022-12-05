part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {
  final String name; 
  final String email;
  final String expediente;

  const ProfileState({
    this.name = '', 
    this.email = '',
    this.expediente = '',
  });
}

class ProfileInitial extends ProfileState {
  const ProfileInitial():super(
    name : '',
    email : '',
    expediente : '',
  );
}


class ProfileUpdateState extends ProfileState {
  const ProfileUpdateState({
    required String name,
    required String email,
    required String expediente
  }):super(
    name : name,
    email : email,
    expediente : expediente
  );
}
