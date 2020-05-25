import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postUpdatePass(
    {String password}) async {
  try {
    Map<String, dynamic> body = {
      "username": ConfigsApp.userName,
      "password": password,
      "name": "null",
      "email": "null",
      "phone": "null",
      "admin": false
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.membersUrl + ConfigsApp.updateUrl + ConfigsApp.passUrl
            : ConfigsApp.baseUrl + ConfigsApp.membersUrl + ConfigsApp.updateUrl + ConfigsApp.passUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'update password success') {
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