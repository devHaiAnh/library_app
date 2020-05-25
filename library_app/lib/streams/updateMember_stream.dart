import 'dart:async';

import 'package:library_app/validations/validations.dart';

class UpdateMemberStream {
  StreamController _nameController = StreamController.broadcast();
  StreamController _emailController = StreamController.broadcast();
  StreamController _phoneController = StreamController.broadcast();
  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get phoneStream => _phoneController.stream;

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
    if (!Validations.isValidPhoneNumber(phone)) {
      _phoneController.sink.addError("This phone number is not valid");
    } else {
      _phoneController.sink.add("ok");
    }
  }

  bool isValidInfo({String name, String email, String phone}) {
    bool status = true;

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
    if (!Validations.isValidPhoneNumber(phone)) {
      _phoneController.sink.addError("This phone number is not valid");
      status = false;
    } else {
      _phoneController.sink.add("ok");
    }
    return status;
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _phoneController.close();
  }
}
