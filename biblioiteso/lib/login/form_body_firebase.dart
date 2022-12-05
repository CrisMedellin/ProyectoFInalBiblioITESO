import 'package:biblioiteso/utils/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import '../pages/search/search.dart';

class FormBodyFirebase extends StatelessWidget {
  FormBodyFirebase({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(
        showAuthActionSwitch: false, // disable navigate to register screen
        headerBuilder: (context, constraints, breakpoint) {
          return Center(
            child: Image.asset("assets/images/voice-recorder.png", height: 120),
          );
        },
        providerConfigs: [
          GoogleProviderConfiguration(clientId: GOOGLE_CLIENT_ID),
        ],
        footerBuilder: (context, action) {
          return Text(
            'By signing in, you agree to our terms and conditions.',
          );
        },
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
