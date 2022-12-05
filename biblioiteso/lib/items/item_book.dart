import 'package:flutter/material.dart';

import '../pages/search/info_book.dart';

class ItemShowBook extends StatelessWidget {
  final dynamic findBook;
  const ItemShowBook({super.key, this.findBook});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => InfoBook(
                  infBook: findBook,
                ),
              ),
            );
          },
          child: Image.network(
            "${findBook["volumeInfo"]["imageLinks"] != null ? findBook["volumeInfo"]["imageLinks"]["thumbnail"] : "https://library.msu.ac.zw/img/nocover.png"}",
            width: 110,
            height: 110,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
          child: Text(
            "${findBook["volumeInfo"]["title"] ?? "no se encontro el titulo"}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        )
      ],
    );
  }
}
