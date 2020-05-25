import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/validations/validations.dart';

part 'total_event.dart';
part 'total_state.dart';

class TotalBloc extends Bloc<TotalEvent, TotalState> {
  @override
  TotalState get initialState => TotalInitial();

  @override
  Stream<TotalState> mapEventToState(
    TotalEvent event,
  ) async* {
    try {
      // if(event is )
      // if (await Validations.isConnectedNetwork()) {}
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
