import 'dart:async';

import 'package:library_app/validations/validations.dart';

class AddMemberStream {
  StreamController _userController = StreamController.broadcast();
  StreamController _passController = StreamController.broadcast();
  StreamController _nameController = StreamController.broadcast();
  StreamController _emailController = StreamController.broadcast();
  StreamController _addressController = StreamController.broadcast();
  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;
  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get addressStream => _addressController.stream;

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

  void addressChange(String address) {
    if (!Validations.isValidText(address)) {
      _addressController.sink.addError("This address is not valid");
    } else {
      _addressController.sink.add("ok");
    }
  }

  bool isValidInfo(
      {String username,
      String password,
      String name,
      String email,
      String address}) {
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
    if (!Validations.isValidText(name)) {
      _nameController.sink.addError("This name is not valid");
      status = false;
    } else {
      _nameController.sink.add("ok");
    }
    if (!Validations.isValidEmail(email)) {
      _emailController.sink.addError("This email is not valid");
      status = false;
    } else {
      _emailController.sink.add("ok");
    }
    if (!Validations.isValidText(address)) {
      _addressController.sink.addError("This address is not valid");
      status = false;
    } else {
      _addressController.sink.add("ok");
    }
    return status;
  }

  void dispose() {
    _userController.close();
    _passController.close();
    _nameController.close();
    _emailController.close();
    _addressController.close();
  }
}
