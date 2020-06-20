import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postAddBookmark(
    {String image,
    String name,
    String author,
    String imageAuthor,
    String writingGenre,
    String achievements,
    double evaluateAuthor,
    double evaluateBook,
    String description,
    String category,
    int pages,
    String cover,
    String language,
    double cost,
    }) async {
  try {
    Map<String, dynamic> body = {
      "image": image,
      "name": name,
      "author": author,
      "imageAuthor": imageAuthor,
      "writingGenre": writingGenre,
      "achievements": achievements,
      "evaluateAuthor": evaluateAuthor,
      "evaluateBook": evaluateBook,
      "description": description,
      "category": category,
      "pages": pages,
      "cover": cover,
      "language": language,
      "cost": cost,
      "username": ConfigsApp.userName
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.bookmarkUrl + ConfigsApp.addUrl
            : ConfigsApp.baseUrl + ConfigsApp.bookmarkUrl + ConfigsApp.addUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'add bookmark success') {
        return 1;
      } else {
        return 0;
      }
    } else {
      print("api error");
      return 0;
    }
  } catch (e) {
    print("error: ${e.toString()}");
  }
}
