import 'package:biblioiteso/items/item_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/loanbook_provider.dart';

class CheckLoanBook extends StatelessWidget {
  const CheckLoanBook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _favorsong = Provider.of<LoanBook>(context);
    _favorsong.getLoanList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Biblioteca Dr. Jorge Villalobos Padilla, SJ'),
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
