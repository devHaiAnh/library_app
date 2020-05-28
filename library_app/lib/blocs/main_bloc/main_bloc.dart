import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/validations/validations.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @override
  MainState get initialState => MainInitial();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    try {
      if (event is CheckInternetEvent) {
        yield LoadingState();
        if (await Validations.isConnectedNetwork()) {
          yield CheckedState();
        } else {
          yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error Internet");
        }
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
