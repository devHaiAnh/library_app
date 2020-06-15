import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/api/cart/delCart_api.dart';
import 'package:library_app/data/api/cart/getCart_api.dart';
import 'package:library_app/data/api/cart/updateCart_api.dart';
import 'package:library_app/data/api/payment/addPayment_api.dart';
import 'package:library_app/data/model/carts_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final dayNow = DateTime.now().millisecondsSinceEpoch;
  final dayFinal = DateTime.now().add(new Duration(days: 7)).millisecondsSinceEpoch;
  @override
  CartState get initialState => CartInitial();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    try {
      // Read
      if (event is LoadCartEvent) {
        yield LoadingState();
        CartsModel cartModel = await getCart();
        if (cartModel?.carts != null) {
          yield LoadedState(cartList: cartModel.carts);
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Update Cart
      if (event is PressButtonUpdateCartEvent) {
        yield LoadingState();
        final result = await postUpdateCart(
            name: event.name,
            count: event.count,
            cost: event.cost,
            username: ConfigsApp.userName);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "SignUp Success");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Delete Cart
      if (event is PressButtonDelCartEvent) {
        yield LoadingState();
        final result =
            await postDelCart(name: event.name, username: ConfigsApp.userName);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Delete Cart Success");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Add Payment
      if (event is PressButtonAddPaymentEvent) {
        yield LoadingState();
        final result = await postAddPayment(
            image: event.cart.image,
            name: event.cart.name,
            author: event.cart.author,
            evaluateBook: event.cart.evaluateBook,
            registrationDate: dayNow,
            expirationDate: dayFinal,
            count: event.cart.count,
            cost: event.cart.cost,
            status: 3,
            username: ConfigsApp.userName);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Add Success");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Add Order
      // if (event is PressButtonAddOrderEvent) {
      //   yield LoadingState();
      //   final result = await postAddOrder(
      //       image: event.cart.image,
      //       name: event.cart.name,
      //       author: event.cart.author,
      //       evaluateBook: event.cart.evaluateBook,
      //       registrationDate: dayNow,
      //       expirationDate: dayFinal,
      //       count: event.cart.count,
      //       cost: event.cart.cost,
      //       status: 3,
      //       username: ConfigsApp.userName);
      //   if (result == 1) {
      //     yield SuccessState(
      //         title: "Congratulations", message: "Add Success");
      //   } else {
      //     yield ErrorState(
      //         errorTitle: "Warning!!!", errorMessage: "Error Sever");
      //   }
      // }
      // Button Back
      if (event is PressButtonBackEvent) {
        Navigator.pop(event.context);
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
