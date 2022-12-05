import 'dart:convert';

import 'package:biblioiteso/pages/loan/Bloc/loans/loans_bloc.dart';
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
    final bookController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Actuales",
              ),
              Tab(
                text: "Prestar",
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

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: idController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: bookController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          _formKey.currentState!.save();
                          print("${_formKey.currentState}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Nuevo prestamo generado')),
                          );
                        }
                      },
                      child: Text('Generar prestamo'),
                    ),
                  ),
                ],
              ),
            ),

            //Center button to open camera page
            Center(
              child: FloatingActionButton(
                onPressed: () async {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Camera()),
                  // );
                  // LoanBloc.add(GenerateBookEvent());
                },
                child: Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
