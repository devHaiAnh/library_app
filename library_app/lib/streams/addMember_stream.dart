import 'dart:async';

import 'package:library_app/validations/validations.dart';

class AddMemberStream {
  StreamController _userController = StreamController.broadcast();
  StreamController _passController = StreamController.broadcast();
  StreamController _nameController = StreamController.broadcast();
  StreamController _emailController = StreamController.broadcast();
  StreamController _phoneController = StreamController.broadcast();
  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;
  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get phoneStream => _phoneController.stream;

  void userChange(String username) {
    if (!Validations.isValidUser(username)) {
      _userController.sink.addError("This account is not valid");
    } else {
      _userController.sink.add("ok");
    }
  }

  void passChange(String password) {
    if (!Validations.isValidPass(password)) {
      _passController.sink.addError("Password must be 4-8 characters long");
    } else {
      _passController.sink.add("ok");
    }
  }

  void nameChange(String name) {
    if (!Validations.isValidText(name)) {
      _nameController.sink.addError("This name is not valid");
    } else {
      _nameController.sink.add("ok");
    }
  }

  void emailChange(String email) {
    if (!Validations.isValidEmail(email)) {
      _emailController.sink.addError("This email is not valid");
    } else {
      _emailController.sink.add("ok");
    }
  }

  void phoneChange(String phone) {
    if (!Validations.isValidUser(phone)) {
      _phoneController.sink.addError("This phone number is not valid");
    } else {
      _phoneController.sink.add("ok");
    }
  }

  bool isValidInfo(
      {String username,
      String password,
      String name,
      String email,
      String phone}) {
    bool status = true;

    if (!Validations.isValidUser(username)) {
      _userController.sink.addError("This account is not valid");
      status = false;
    } else {
      _userController.sink.add("ok");
    }
    if (!Validations.isValidPass(password)) {
      _passController.sink.addError("Password must be 4-8 characters long");
      status = false;
    } else {
      _passController.sink.add("ok");
    }
    if (!Validations.isValidUser(name)) {
      _nameController.sink.addError("This name is not valid");
      status = false;
    } else {
      _nameController.sink.add("ok");
    }
    if (!Validations.isValidPass(email)) {
      _emailController.sink.addError("This email is not valid");
      status = false;
    } else {
      _emailController.sink.add("ok");
    }
    if (!Validations.isValidUser(phone)) {
      _phoneController.sink.addError("This phone number is not valid");
      status = false;
    } else {
      _phoneController.sink.add("ok");
    }
    return status;
  }

  void dispose() {
    _userController.close();
    _passController.close();
    _nameController.close();
    _emailController.close();
    _phoneController.close();
  }
}
