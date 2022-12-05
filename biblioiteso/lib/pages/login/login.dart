import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://www.google.com/search?q=iteso+login&client=opera-gx&hs=Eve&sxsrf=ALiCzsYeVj_WYB3Ln9Ai8xbYyjAR9umjzQ:1665895596493&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjb3Iva-OP6AhXdomoFHZbUCgsQ_AUoAXoECAIQAw&biw=1766&bih=928&dpr=0.75#imgrc=o6_OrmxEnxKfVM",
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.white,
                controller: searchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "ingresar editorial",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    suffixIcon: Icon(FontAwesomeIcons.bookmark)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.white,
                controller: searchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "ingresar editorial",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    suffixIcon: Icon(FontAwesomeIcons.bookmark)),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
