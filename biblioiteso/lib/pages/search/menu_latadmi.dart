import 'package:biblioiteso/pages/loan/Bloc/loans/loans_bloc.dart';
import 'package:biblioiteso/pages/loan/loan.dart';
import 'package:biblioiteso/pages/search/info_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/loanbook_provider.dart';
import '../loan/loanadmi.dart';
import '../login/login.dart';
import '../profile/profile.dart';
import '../register/register.dart';

class MenuLateralAmdmi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Lbloc = BlocProvider.of<LoansBloc>(context, listen: false);

    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("CODEA APP"),
            accountEmail: Text("informes@gmail.com"),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://iteso.mx/image/journal/article?img_id=14589651&t=1548117030845"),
                    fit: BoxFit.cover)),
          ),
          new ListTile(
            leading: Icon(FontAwesomeIcons.toolbox),
            title: Text("-Profile"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
          ),
          new ListTile(
            leading: Icon(FontAwesomeIcons.book),
            title: Text("-Loan "),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CheckLoanBook(),
                ),
              );
            },
          ),
          new ListTile(
            leading: Icon(Icons.notifications),
            title: Text("-Admin Loans"),
            onTap: () {
              Lbloc.add(GetLoansEvent());
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Loan(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
