import 'package:biblioiteso/items/item_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../providers/loanbook_provider.dart';
import '../profile/bloc/profile/profile_bloc.dart';
import 'Bloc/loans/loans_bloc.dart';
import 'loanadmi.dart';

class CheckLoanBook extends StatelessWidget {
  const CheckLoanBook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _favorsong = Provider.of<LoanBook>(context);
    final pBloc = BlocProvider.of<ProfileBloc>(context, listen: false);
    final Lbloc = BlocProvider.of<LoansBloc>(context, listen: false);
    _favorsong.getLoanList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loans'),
          actions: [
            MaterialButton(
                onPressed: () {},
                onLongPress: () {
                  print(pBloc.state.admin);
                  if (pBloc.state.admin) {
                    Lbloc.add(GetLoansEvent());
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Loan(),
                      ),
                    );
                  }
                },
                child: Icon(Icons.admin_panel_settings)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: _favorsong.getaddedFavoriteteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemShowBook(
                          findBook: _favorsong.getaddedFavoriteteList[index]);
                    }),
              ),
            )
          ],
        ));
  }
}
