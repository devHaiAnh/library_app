import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/model/books_model.dart';

Future<dynamic> getBook() async {
  try {
    Response response = await get(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.bookUrl
            : ConfigsApp.baseUrl + ConfigsApp.bookUrl,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'get book success') {
        return BooksModel.fromJson(data);
      } else {
        return null;
      }
    } else {
      print("api error");
      return null;
    }
  } catch (e) {
    print("error: ${e.toString()}");
    return null;
  }
}