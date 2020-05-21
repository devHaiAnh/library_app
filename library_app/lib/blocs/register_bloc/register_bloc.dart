import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/api/register_api.dart';
import 'package:library_app/streams/register_stream.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    try {
      if (event is PressButtonRegisterEvent) {
        yield LoadingState();
        if (event.registerStream.isValidInfo(
            username: event.username.trim(),
            password: event.passowrd.trim(),
            email: event.email.trim())) {
          final result = await postRegister(
              username: event.username.trim(),
              password: event.passowrd.trim(),
              email: event.email.trim());
          if (result == 1) {
            yield SuccessState(title: "Congratulations", message: "SignUp Success");
            Navigator.pop(event.context);
          } else {
            yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error Sever");
          }
        }
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
