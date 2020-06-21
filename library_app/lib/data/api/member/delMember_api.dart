import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postDelMember(
    {String username}) async {
  try {
    Map<String, dynamic> body = {
      "username": username,
      "password": "null",
      "name": "null",
      "email": "null",
      "address": "null",
      "admin": false
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.membersUrl + ConfigsApp.delUrl
            : ConfigsApp.baseUrl + ConfigsApp.membersUrl + ConfigsApp.delUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'delete member success') {
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