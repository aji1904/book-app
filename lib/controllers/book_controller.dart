import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/BookDetailResponse.dart';
import '../models/BookListResponse.dart';

class BookController extends ChangeNotifier {
  BookListResponse? bookListResponse;

  // ignore: non_constant_identifier_names
  FetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      bookListResponse = BookListResponse.fromJson(jsonResponse);
      notifyListeners();

      // print('Number of books about http: ${response.body}.');
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }

  BookDetailResponse? detailBook;

  // ignore: non_constant_identifier_names
  FetchDetailBookApi(isbn) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview

    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonResponse);
      notifyListeners();
      FetchRecomendedBookApi(detailBook!.title!);

      // print('Number of books about http: ${response.body}.');
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }

  BookListResponse? similiarBook;

  // ignore: non_constant_identifier_names
  FetchRecomendedBookApi(String title) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/$title');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      similiarBook = BookListResponse.fromJson(jsonResponse);
      notifyListeners();

      // print('Number of books about http: ${response.body}.');
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }
}
