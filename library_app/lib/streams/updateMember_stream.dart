import 'dart:async';

import 'package:library_app/validations/validations.dart';

class UpdateMemberStream {
  StreamController _nameController = StreamController.broadcast();
  StreamController _emailController = StreamController.broadcast();
  StreamController _addressController = StreamController.broadcast();
  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get addressStream => _addressController.stream;

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

  bool isValidInfo({String name, String email, String address}) {
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
    if (!Validations.isValidText(address)) {
      _addressController.sink.addError("This address is not valid");
      status = false;
    } else {
      _addressController.sink.add("ok");
    }
    return status;
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _addressController.close();
  }
}
