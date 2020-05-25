import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/model/members_model.dart';

Future<dynamic> getMember() async {
  try {
    Response response = await get(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.membersUrl
            : ConfigsApp.baseUrl + ConfigsApp.membersUrl,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'get member success') {
        return MembersModel.fromJson(data);
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