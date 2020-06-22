import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/model/login_model.dart';

Future<dynamic> postLogin({String username, String password}) async {
  try {
    Map<String, dynamic> body = {
      "username": username,
      "password": password,
      "name": "null",
      "email": "null",
      "address": "",
      "admin": false
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.loginUrl
            : ConfigsApp.baseUrl + ConfigsApp.loginUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['state'] == 1) {
        return LoginModel.fromJson(data);
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
