import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postAddBookmark(
    {String image,
    String name,
    String author,
    double evaluateBook,
    String description}) async {
  try {
    Map<String, dynamic> body = {
      "image": image,
      "name": name,
      "author": author,
      "evaluateBook": evaluateBook,
      "description": description,
      "registrationDate": 0,
      "expirationDate": 0,
      "status": 0,
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
