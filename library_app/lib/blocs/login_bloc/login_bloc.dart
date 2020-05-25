import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/forgot_pass_bloc/forgot_pass_bloc.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/api/login_register_forgot/login_api.dart';
import 'package:library_app/data/model/login_model.dart';
import 'package:library_app/screens/login_register_forgot/forgotPassword.dart';
import 'package:library_app/screens/login_register_forgot/signupScreen.dart';
import 'package:library_app/screens/totalScreen.dart';
import 'package:library_app/streams/login_stream.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is PressButtonLoginEvent) {
        yield LoadingState();
        // if (event.loginStream.isValidInfo(
        //     username: event.username, password: event.passowrd)) {
        LoginModel loginModel =
            await postLogin(username: event.username, password: event.passowrd);
        if (loginModel.message == "login success") {
          yield SuccessState();
          ConfigsApp.userName = loginModel.member.username;
          ConfigsApp.passWord = loginModel.member.password;
          Navigator.push(
              event.context,
              MaterialPageRoute(
                  builder: (context) => TotalPage(member: loginModel.member)));
        } else if (loginModel.message == "wrong password") {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Wrong Password");
        } else if (loginModel.message == "wrong username") {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Account does not exist");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
        // } else {
        //   yield ErrorState(
        //       errorTitle: "Warning!!!",
        //       errorMessage: "The data entered is not in the correct format");
        // }
      }
      if (event is PressButtonMoveForgotEvent) {
        yield LoadingState();
        Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
      }
      if (event is PressButtonMoveRegisterEvent) {
        yield LoadingState();
        Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => SignUpPage()));
      }
      if (event is SavePasswordEvent) {
        // if(event.savePass){
        //   addStringToSF() async {
        //     SharedPreferences prefs = await SharedPreferences.getInstance();
        //     prefs.setString('stringValue', "abc");
        //   }
        // }
        yield SavePasswordState(savePass: !event.savePass);
      }
      if (event is ShowPasswordEvent) {
        yield ShowPasswordState(showPass: !event.showPass);
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
