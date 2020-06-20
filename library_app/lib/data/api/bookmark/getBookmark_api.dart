import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/model/bookmarks_model.dart';

Future<dynamic> getBookmark(
    ) async {
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
      "category": "category",
      "pages": 1,
      "cover": "cover",
      "language": "language",
      "cost": 11.11,
      "username": ConfigsApp.userName
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.bookmarkUrl
            : ConfigsApp.baseUrl + ConfigsApp.bookmarkUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'get bookmark success') {
        return BookmarksModel.fromJson(data);
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