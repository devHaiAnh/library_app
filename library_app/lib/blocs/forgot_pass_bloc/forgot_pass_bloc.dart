import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/register_bloc/register_bloc.dart';
import 'package:library_app/data/api/fotgotPass_api.dart';
import 'package:library_app/streams/forgotPass_stream.dart';

part 'forgot_pass_event.dart';
part 'forgot_pass_state.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  @override
  ForgotPassState get initialState => ForgotPassInitial();

  @override
  Stream<ForgotPassState> mapEventToState(
    ForgotPassEvent event,
  ) async* {
    try {
      if (event is PressButtonForgotPassEvent) {
        yield LoadingState();
        if (event.forgotPassStream.isValidInfo(
            username: event.username.trim(),
            password: event.passowrd.trim(),
            email: event.email.trim())) {
          final result = await postForgotPass(
              username: event.username.trim(),
              password: event.passowrd.trim(),
              email: event.email.trim());
          if (result == 1) {
            yield SuccessState(title: "Congratulations", message: "Change Password Success");
            Navigator.pop(event.context);
          } else if (result == 2) {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Wrong Email");
          } else if (result == 3) {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Wrong Username");
          } else {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Error Server");
          }
        }
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
