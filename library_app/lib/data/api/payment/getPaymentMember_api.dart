import 'dart:convert';

import 'package:http/http.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/model/payments_model.dart';

Future<dynamic> getPaymentMember({String username}) async {
  try {
    Map<String, dynamic> body = {
      "image": "image",
      "name": "name",
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
            ? ConfigsApp.baseUrl + ConfigsApp.paymentUrl
            : ConfigsApp.baseUrl + ConfigsApp.paymentUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'get payment success') {
        return PaymentsModel.fromJson(data);
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