import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postUpdateMembers(
    {String username, String name, String email, String phone, bool admin}) async {
  try {
    Map<String, dynamic> body = {
      "username": username,
      "password": "null",
      "name": name,
      "email": email,
      "phone": phone,
      "admin": admin
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.membersUrl + ConfigsApp.updateUrl
            : ConfigsApp.baseUrl + ConfigsApp.membersUrl + ConfigsApp.updateUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'update member success') {
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