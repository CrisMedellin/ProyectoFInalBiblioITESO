import 'dart:convert';

import 'package:biblioiteso/pages/loan/Bloc/loans/loans_bloc.dart';
import 'package:biblioiteso/pages/loan/loans_cam.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loan extends StatelessWidget {
  const Loan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoanBloc = BlocProvider.of<LoansBloc>(context, listen: false);
    final idController = TextEditingController();
    // final bookController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Actuales",
              ),
              Tab(
                text: "Recibir",
              ),
            ],
          ),
          title: Text('Prestamos'),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<LoansBloc, LoansState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.loansCount,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          "User: ${jsonDecode(state.loansList)[index]["nombre"]} - '${jsonDecode(state.loansList)[index]["expediente"]}'"),
                      subtitle: Text(
                          "Entrega el día ${jsonDecode(state.loansList)[index]["dateToReturn"]} el libro '${jsonDecode(state.loansList)[index]["title"]}'"),
                    );
                  },
                );
              },
            ),

            //Formulario con una entrada de texto y un botón
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: idController,
                    decoration: InputDecoration(
                      labelText: "ID del usuario",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el ID del usuario';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoansCamera()),
                          );
                          // LoanBloc.add(GenerateBookEvent());
                        },
                        child: Icon(Icons.camera_alt),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirmación"),
                                  content: Text(
                                      "¿Desea confirmar la devolución del libro '${LoanBloc.state.bookToReturn}' al usuario con ID '${idController.text}'?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        LoanBloc.add(ReturnLoanEvent(bookToReturn: LoanBloc.state.bookToReturn, userID: idController.text));
                                        LoanBloc.add(GetLoansEvent());
                                        Navigator.pop(context);
                                        idController.clear();
                                      },
                                      child: Text("Confirmar"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancelar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text('Recibir'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Center button to open camera page
            // Center(
            //   child: 
            // ),
          ],
        ),
      ),
    );
  }
}
