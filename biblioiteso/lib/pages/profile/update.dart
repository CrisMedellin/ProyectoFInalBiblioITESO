import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/profile/profile_bloc.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfBloc = BlocProvider.of<ProfileBloc>(context, listen: false);
    final expedienteController = TextEditingController();
    final correoITESOController = TextEditingController();
    final nombreController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Completar Perfil'),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text field for name
                  TextField(
                    controller: expedienteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expediente (Solo números)',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Text field for email
                  TextField(
                    controller: correoITESOController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo Institucional',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Text field for email
                  TextField(
                    controller: nombreController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre Completo',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Button to update profile
                  ElevatedButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Perfil actualizado')),
                      );
                      ProfBloc.add(UpdateProfileEvent(
                        expediente: expedienteController.text,
                        correo: correoITESOController.text,
                        nombre: nombreController.text,
                      ));

                      ProfBloc.add(SaveProfileEvent());

                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: Text('Actualizar'),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
