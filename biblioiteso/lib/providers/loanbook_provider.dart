import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoanBook with ChangeNotifier {
  List<dynamic> _addedFavoriteteList = [];
  List<dynamic> get getaddedFavoriteteList => _addedFavoriteteList;
  String? _uid = "";
  void dlateTrack(dynamic ObjecTrack) {
    _addedFavoriteteList.remove(ObjecTrack);
    notifyListeners();
  }

  void addTrack(dynamic ObjecTrack) {
    if (!_addedFavoriteteList.contains(ObjecTrack)) {
      _addedFavoriteteList.add(ObjecTrack);
      print(_addedFavoriteteList);
      notifyListeners();
    }
  }

  bool isInFavoriteList(dynamic musicObj) {
    getLoanList();
    return _addedFavoriteteList.contains(musicObj);
  }

  Widget Item_add(BuildContext context, dynamic objec) {
    return IconButton(
        onPressed: () {
          addLoan(objec);
          print("loans");
          Navigator.of(context).pop();
          notifyListeners();
        },
        tooltip: 'solicitar libro',
        icon: Icon(Icons.book));
  }

  Widget Item_Delate(BuildContext context, dynamic objec) {
    return IconButton(
        onPressed: () {
          print("La cancion es favorita? ${isInFavoriteList(objec)}");
          showDialog(
              context: context,
              builder: (builder) => AlertDialog(
                    title: Text("Eliminar de favoritos"),
                    content: Text("El elemento será eliminado de sus favorito"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("abortar")),
                      TextButton(
                          onPressed: () {
                            freeLoan(objec);
                            print("favoritos");
                            Navigator.of(context).pop();
                            notifyListeners();
                          },
                          child: Text("delete"))
                    ],
                  ));
        },
        icon: Icon(Icons.favorite, color: Colors.red));
  }

  //----------------------------------------------------------------------------------

  void addLoan(dynamic musicObj) async {
    Map<String, dynamic> ListToSend = musicObj;

    ListToSend['dateToReturn'] =
        DateTime.now().add(Duration(days: 7)).toString().split(' ')[0];
    print(ListToSend);
    if (!_addedFavoriteteList.contains(musicObj)) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "loans": FieldValue.arrayUnion([ListToSend]),
        'user_id': FirebaseAuth.instance.currentUser!.uid,
      });
    }
    getLoanList();
    notifyListeners();
  }

  void takeFavoritesongList() async {
    getLoanList();
    notifyListeners();
  }

  void freeLoan(dynamic musicObj) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "loans": FieldValue.arrayRemove([musicObj]),
      'user_id': FirebaseAuth.instance.currentUser!.uid
    });
    getLoanList();
    notifyListeners();
  }

  void getLoanList() async {
    try {
      var myCollection = await FirebaseFirestore.instance
          .collection('user')
          .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      var mySongs = myCollection.docs.first.data()['loans'];
      log(mySongs.toString());
      if (mySongs != null) {
        _addedFavoriteteList = mySongs;
        notifyListeners();
      }
    } catch (e) {
      _addedFavoriteteList = [];
    }
  }
}
