import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/model/books_model.dart';

Future<dynamic> getBookCategory({String category}) async {
  try {
    Map<String, dynamic> body = {
      "image": "image",
      "name": "name",
      "author": "author",
      "imageAuthor": "imageAuthor",
      "writingGenre": "writingGenre",
      "achievements": "achievements",
      "evaluateAuthor": 5.0,
      "evaluateBook": 5.0,
      "description": "description",
      "category": category,
      "pages": 1,
      "cover": "cover",
      "language": "language",
      "cost": 11.11
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.bookUrl
            : ConfigsApp.baseUrl + ConfigsApp.bookUrl,
        body: finalBody,
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
