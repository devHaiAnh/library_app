import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postDelBookmark({String name}) async {
  try {
    Map<String, dynamic> body = {
      "image": "image",
      "name": name,
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
            ? ConfigsApp.baseUrl + ConfigsApp.bookmarkUrl + ConfigsApp.delUrl
            : ConfigsApp.baseUrl + ConfigsApp.bookmarkUrl + ConfigsApp.delUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'delete bookmark success') {
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
