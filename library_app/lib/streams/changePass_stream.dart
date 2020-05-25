import 'dart:async';

import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/validations/validations.dart';

class ChangePassStream {
  StreamController _passOldController = StreamController.broadcast();
  StreamController _passNewController = StreamController.broadcast();
  StreamController _passRetypeController = StreamController.broadcast();
  Stream get passOldStream => _passOldController.stream;
  Stream get passNewStream => _passNewController.stream;
  Stream get passRetypeStream => _passRetypeController.stream;

  void passOldChange(String password) {
    if (!Validations.isValidPass(password)) {
      _passOldController.sink.addError("Password must be 4-8 characters long");
    } else if (password != ConfigsApp.passWord) {
      _passOldController.sink.addError("Does not match the old password");
    } else {
      _passOldController.sink.add("ok");
    }
  }

  void passNewChange(String password) {
    if (!Validations.isValidPass(password)) {
      _passNewController.sink.addError("Password must be 4-8 characters long");
    } else {
      _passNewController.sink.add("ok");
    }
  }

  void passRetypeChange(String pass, String repass) {
    if (!Validations.isValidConfirmPass(pass, repass)) {
      _passRetypeController.sink.addError("Retype password does not match");
    } else {
      _passRetypeController.sink.add("Ok");
    }
  }

  bool isValidInfo(
      {String passwordOld, String passwordNew, String repassword}) {
    bool status = true;
    if (!Validations.isValidPass(passwordOld)) {
      status = false;
    } else {}
    if (!Validations.isValidPass(passwordNew)) {
      status = false;
    } else {}
    if (!Validations.isValidConfirmPass(passwordNew, repassword)) {
      status = false;
    } else {}
    return status;
  }

  void dispose() {
    _passOldController.close();
    _passNewController.close();
    _passRetypeController.close();
  }
}
