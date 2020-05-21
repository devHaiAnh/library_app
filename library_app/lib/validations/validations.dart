import 'dart:io';

class Validations {
  static Future<bool> isConnectedNetwork() async {
    bool status = false;
    try {
      final result = await InternetAddress.lookup('unionist.pikatech.vn')
          .timeout(const Duration(seconds: 20));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = true;
        return status;
      }
    } on SocketException catch (_) {
      status = false;
      return status;
    }
    return status;
  }

  static bool isValidText(String text) {
    return text != null && text.length > 0;
  }

  static bool isValidUser(String user) {
    return user != null && user.length > 0;
  }

  static bool isValidPass(String pass) {
    return pass != null && pass.length >= 0 && pass.length <= 8;
  }

  static bool isValidConfirmPass(String pass, String confirmpass) {
    return confirmpass != null && confirmpass.length > 0 && pass == confirmpass;
  }

  static bool isValidPhoneNumber(String number) {
    RegExp regExp = new RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    return regExp.hasMatch(number);
  }

  static bool isValidEmail(String email) {
    RegExp reg = new RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return reg.hasMatch(email);
  }
}
