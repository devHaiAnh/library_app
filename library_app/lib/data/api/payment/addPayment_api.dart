import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';

Future<int> postAddPayment(
    {String image,
    String name,
    String author,
    double evaluateBook,
    int registrationDate,
    int expirationDate,
    int count,
    double cost,
    int status,
    String username}) async {
  try {
    Map<String, dynamic> body = {
      "image": image,
      "name": name,
      "author": author,
      "evaluateBook": evaluateBook,
      "registrationDate": registrationDate,
      "expirationDate": expirationDate,
      "count": count,
      "cost": cost,
      "status": status,
      "username": username
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.paymentUrl + ConfigsApp.addUrl
            : ConfigsApp.baseUrl + ConfigsApp.paymentUrl + ConfigsApp.addUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'add payment success') {
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