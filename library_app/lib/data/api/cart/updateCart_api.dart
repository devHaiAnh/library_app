import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postUpdateCart(
    {String name,
    int count,
    double cost,
    String username}) async {
  try {
    Map<String, dynamic> body = {
      "image": "image",
      "name": name,
      "author": "author",
      "evaluateBook": 2.0,
      "description": "description",
      "count": count,
      "cost": cost,
      "username": username
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.cartUrl + ConfigsApp.updateUrl
            : ConfigsApp.baseUrl + ConfigsApp.cartUrl + ConfigsApp.updateUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'update cart success') {
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