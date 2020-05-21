import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postForgotPass({
  String username,
  String password,
  String email,
}) async {
  try {
    Map<String, dynamic> body = {
      "username": username,
      "password": password,
      "name": "null",
      "email": email,
      "phone": 0,
      "admin": false
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.forgotPassUrl
            : ConfigsApp.baseUrl + ConfigsApp.forgotPassUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'update password success') {
        return 1;
      } else if (data['message'] == 'wrong email') {
        return 2;
      } else if (data['message'] == 'wrong username') {
        return 3;
      } else {
        return 0;
      }
    } else {
      print("api error");
      return 0;
    }
  } catch (e) {
    print("error: ${e.toString()}");
    return 0;
  }
}
