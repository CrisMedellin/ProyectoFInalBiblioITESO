part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {
  final String name;
  final String email;
  final String expediente;
  final bool admin;

  const ProfileState({
    this.name = '',
    this.email = '',
    this.expediente = '',
    this.admin = false,
  });
}

class ProfileInitial extends ProfileState {
  const ProfileInitial()
      : super(name: '', email: '', expediente: '', admin: false);
}

class ProfileUpdateState extends ProfileState {
  const ProfileUpdateState({
    required String name,
    required String email,
    required String expediente,
    required bool admin,
  }) : super(name: name, email: email, expediente: expediente, admin: admin);
}
