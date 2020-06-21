import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/api/payment/delPayment_api.dart';
import 'package:library_app/data/api/payment/getPaymentMember_api.dart';
import 'package:library_app/data/api/payment/getPayment_api.dart';
import 'package:library_app/data/model/payments_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  @override
  PaymentState get initialState => PaymentInitial();

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    try {
      // Read All
      if (event is LoadPaymentEvent) {
        yield LoadingState();
        PaymentsModel paymentModel = await getPayment();
        if (paymentModel?.payments != null) {
          yield LoadedPaymentState(paymentList: paymentModel.payments);
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Read Member
      if (event is LoadPaymentMemberEvent) {
        yield LoadingState();
        PaymentsModel paymentModel =
            await getPaymentMember(username: event.username);
        if (paymentModel?.payments != null) {
          yield LoadedPaymentState(paymentList: paymentModel.payments);
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Delete Cart
      if (event is PressButtonDelPaymentEvent) {
        yield LoadingState();
        final result = await postDelPayment(
            name: event.name, username: ConfigsApp.userName);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Delete Cart Success");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Button Back
      if (event is PressButtonBackEvent) {
        Navigator.pop(event.context);
      }
      if (event is MovePaymentEvent) {
        yield MovePaymentState(data: event.data, registed: event.registed);
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
