part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class UpdateEmailEvent extends ProfileEvent {
  final String email;

  UpdateEmailEvent({
    required this.email,
  });
}

class UpdateExpedienteEvent extends ProfileEvent {
  final int expediente;

  UpdateExpedienteEvent({
    required this.expediente,
  });
}

class UpdateProfileEvent extends ProfileEvent {
  final String correo;
  final String expediente;
  final String nombre;

  UpdateProfileEvent({
    required this.correo,
    required this.expediente,
    required this.nombre,
  });
}

class SaveProfileEvent extends ProfileEvent {
  SaveProfileEvent();
}
