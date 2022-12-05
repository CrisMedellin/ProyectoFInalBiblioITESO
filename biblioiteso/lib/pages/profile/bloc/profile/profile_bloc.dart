import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) async {
      try {
        if (event.correo != "") {
          if (event.correo.contains("@iteso.mx")) {
            await FirebaseFirestore.instance
                .collection('user')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
                  "correoITESO": event.correo,
                })
                .then((value) => print("User Email Updated"))
                .catchError((error) => print("Failed to update user: $error"));
          }
        }

        if (event.expediente != '') {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
                "expediente": event.expediente,
              })
              .then((value) => print("User ID Updated"))
              .catchError((error) => print("Failed to update user: $error"));
        }

        if (event.nombre != '') {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
                "nombre": event.nombre,
              })
              .then((value) => print("User Name Updated"))
              .catchError((error) => print("Failed to update user: $error"));
        }
      } catch (e) {
        print(e);
      }
    });

    on<SaveProfileEvent>((event, emit) async {
      try {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            Map<String, dynamic> userInfo =
                documentSnapshot.data() as Map<String, dynamic>;
            emit(ProfileUpdateState(
              name:
                  userInfo['nombre'] != null ? userInfo['nombre'] : 'Pendiente',
              email: userInfo['correoITESO'] != null
                  ? userInfo['correoITESO']
                  : 'Pendiente',
              expediente: userInfo['expediente'] != null
                  ? userInfo['expediente']
                  : 'Pendiente',
            ));
          } else {
            print('Document does not exist on the database');
          }
        });
      } catch (e) {
        print(e);
      }
    });
  }
}
