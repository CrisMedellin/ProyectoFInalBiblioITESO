import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class RepoBook {
  static final RepoBook repoBook = RepoBook._internal();
  factory RepoBook() => repoBook;
  RepoBook._internal();

  Future<dynamic> getBooks(String titleBook) async {
    dynamic bList;
    final req = Uri(
        scheme: "https",
        host: "www.googleapis.com",
        path: "books/v1/volumes",
        queryParameters: {"q": titleBook});
    try {
      dynamic response = await get(req);
      bList = jsonDecode(response.body);
      print(bList);
      return bList;
    } catch (e) {
      throw "hubo un error";
    }
  }

  Future<dynamic> getLoanList(String keyString, String typeSearch) async {
    List<dynamic> bList;
    List<dynamic> FList = [];
    try {
      var myCollection = await FirebaseFirestore.instance
          .collection('acervo')
          .where("public", isEqualTo: true)
          .get();
      var mySongs = myCollection.docs.first.data()['acerv'];
      log(mySongs.toString());

      if (mySongs != 'Todos') {
        bList = mySongs;
        print(bList.length);
        if (keyString != '') {
          for (var index in bList) {
            if (index['volumeInfo'][typeSearch].toString().toLowerCase() ==
                keyString.toLowerCase()) {
              FList.add(index);
            }
          }
        } else {
          return bList;
        }
        return FList;
      }
    } catch (e) {
      print(e);
      throw "hubo un error";
    }
  }
}
