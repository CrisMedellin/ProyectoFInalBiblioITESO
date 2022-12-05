import 'package:biblioiteso/pages/search/menu_latadmi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../camera_qr.dart/camera.dart';
import '../../items/item_book.dart';
import '../../providers/loanbook_provider.dart';
import 'bloc/search_book_bloc.dart';
import 'menu_laterarl.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> dropItemGroup = <String>[
    'ISBN',
    'category',
    'title',
    'autor',
    'Todos',
  ];
  bool admi = false;
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: const Text('Biblioteca Dr. Jorge Villalobos Padilla, SJ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.scanner),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Camera(),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (builder) => AlertDialog(
                  title: Text("Sign out"),
                  content: Text(
                      "El cierre de su sesion lo llevara a la pantalla de inicio,¿Quieres continuar?"),
                  actions: [
                    TextButton(
                      child: Text("abortar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Cerrar sesión"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                      },
                    ),
                  ],
                ),
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              radius: 20,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.white,
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "ingresar titulo",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    BlocProvider.of<SearchBookBloc>(context).add(
                        SearchingBookEvent(
                            titleSearch: searchController.text,
                            selec: dropdownValue!));
                    print(dropdownValue);
                  },
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Busqueda por:'),
            trailing: DropdownButton<String>(
              items: dropDownItemsGenerator(),
              value: dropdownValue,
              onChanged: ((String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              }),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBookBloc, SearchBookState>(
              builder: (context, state) {
                if (state is SearchingState) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return const VideoShimmer();
                    },
                  );
                } else if (state is ErrorInSearchingState) {
                  return const Center(
                    child: Text('hubo un error en la busqueda del libro'),
                  );
                } else if (state is FoundInSearchState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: state.findBooks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemShowBook(findBook: state.findBooks[index]);
                        }),
                  );
                } else {
                  return const Center(
                    child: Text('Ingrese una palabra para buscar el libro'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  dropDownItemsGenerator() {
    return dropItemGroup
        .map(
          (entry) => DropdownMenuItem<String>(
            child: Text(entry),
            value: entry,
          ),
        )
        .toList();
  }
}
