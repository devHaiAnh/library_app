import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/api/login_api.dart';
import 'package:library_app/screens/login_register_forgot/forgotPassword.dart';
import 'package:library_app/screens/login_register_forgot/signupScreen.dart';
import 'package:library_app/screens/totalScreen.dart';
import 'package:library_app/streams/login_stream.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        if (event.loginStream.isValidInfo(
            username: event.username.trim(), password: event.passowrd.trim())) {
          final result = await postLogin(
              username: event.username.trim(), password: event.passowrd.trim());
          if (result == 1) {
            yield SuccessState();
            ConfigsApp.userName = event.username.trim();
            Navigator.push(event.context,
                MaterialPageRoute(builder: (context) => TotalPage()));
          } else if (result == 2) {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Wrong Password");
          } else if (result == 3) {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Wrong Username");
          } else {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Error Sever");
          }
        }
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
