import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postDelCart({String name, String username}) async {
  try {
    Map<String, dynamic> body = {
      "image": "image",
      "name": name,
      "author": "author",
      "evaluateBook": 1.0,
      "description": "description",
      "count": 1,
      "cost": 11.22,
      "username": ConfigsApp.userName
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.cartUrl + ConfigsApp.delUrl
            : ConfigsApp.baseUrl + ConfigsApp.cartUrl + ConfigsApp.delUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'delete cart success') {
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
