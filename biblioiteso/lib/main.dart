import 'package:biblioiteso/auth/bloc/auth_bloc.dart';
import 'package:biblioiteso/pages/loan/Bloc/loans/loans_bloc.dart';
import 'package:biblioiteso/pages/profile/bloc/profile/profile_bloc.dart';
import 'package:biblioiteso/pages/search/bloc/search_book_bloc.dart';
import 'package:biblioiteso/pages/search/search.dart';
import 'package:biblioiteso/providers/loanbook_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc()..add(VerifyAuthEvent()),
      ),
      BlocProvider(
        create: (context) => SearchBookBloc(),
      ),
      BlocProvider(
        create: (_) => ProfileBloc(),
      ),
      BlocProvider(
        create: (_) => LoansBloc(),
      ),
    ],
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoanBook()),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Favor de autenticarse"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return SearchPage();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
