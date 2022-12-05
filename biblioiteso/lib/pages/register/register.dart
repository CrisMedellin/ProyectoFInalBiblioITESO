import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterBook extends StatelessWidget {
  const RegisterBook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Libros'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Ingrese los datos del libro",
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
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
                    "Ingresar titulo",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  suffixIcon: Icon(FontAwesomeIcons.book)),
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
                    "ingresar el Autor",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  suffixIcon: Icon(FontAwesomeIcons.person)),
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
                    "ingresar el SBN del libro",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  suffixIcon: Icon(FontAwesomeIcons.rectangleAd)),
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
          Center(
            child: MaterialButton(
              color: Colors.indigo,
              onPressed: () {},
              child: Text(
                "Terminar Registro",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
