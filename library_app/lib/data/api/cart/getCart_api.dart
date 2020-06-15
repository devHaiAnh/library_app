import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/model/carts_model.dart';

Future<dynamic> getCart({String username}) async {
  try {
    Map<String, dynamic> body = {
      "image": "image",
      "name": "name",
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
            ? ConfigsApp.baseUrl + ConfigsApp.cartUrl
            : ConfigsApp.baseUrl + ConfigsApp.cartUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'get cart success') {
        return CartsModel.fromJson(data);
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