import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postDelPayment({String name, String username}) async {
  try {
    Map<String, dynamic> body = {
      "image": "image",
      "name": name,
      "author": "author",
      "evaluateBook": 2.0,
      "registrationDate": 11111111,
      "expirationDate": 11111111,
      "count": 1,
      "cost": 11.11,
      "status": 1,
      "username": username
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.paymentUrl + ConfigsApp.delUrl
            : ConfigsApp.baseUrl + ConfigsApp.paymentUrl + ConfigsApp.delUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'delete payment success') {
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
