import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/model/login_model.dart';
import 'package:library_app/screens/home/bookListHome.dart';
import 'package:library_app/screens/home/categoryBookHome.dart';
import 'package:library_app/screens/home/categoryListHome.dart';
import 'package:library_app/screens/member/changePasswordScreen.dart';
import 'package:library_app/screens/member/editMemberScreen.dart';
import 'package:library_app/screens/payment_order/paymentHistoryScreen.dart';
import 'package:library_app/screens/widget/qrScreen.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    try {
      // member
      if (event is PressBtnLogoutEvent) {
        Navigator.pop(event.context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder:
        //             (context) =>
        //                 QRPage(
        //                   data: widget
        //                           .book
        //                           .name +
        //                       widget
        //                           .book
        //                           .author +
        //                       "Read Rental",
        //                   registed:
        //                       false,
        //                 )));
      }
      if (event is PressBtnBackEvent) {
        Navigator.pop(event.context);
      }
      if (event is PressBtnMoveEditEvent) {
        Navigator.push(
            event.context,
            MaterialPageRoute(
                builder: (context) => EditMemberPage(
                      member: event.member,
                    )));
      }
      if (event is PressBtnMoveChangePassEvent) {
        Navigator.pop(event.context);
        Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => ChangePasswordPage()));
      }
      // category
      if (event is PressBtnMoveCategoryEvent) {
        Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => CategoryBookHomePage()));
      }
      if (event is PressBtnMoveCategoryAllEvent) {
        Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => CategoryListHomePage()));
      }
      // trending
      if (event is PressBtnMoveTrendingEvent) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => BookPage(
        //               book: bookList[index],
        //             )));
      }
      if (event is PressBtnMoveTrendingAllEvent) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => BookListHomePage(title: "Trending"),
          ),
        );
      }
      // new book
      if (event is PressBtnMoveNewBookEvent) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => BookPage(
        //               book: bookList[index],
        //             )))
      }
      if (event is PressBtnMoveNewBookAllEvent) {
        Navigator.push(
            event.context,
            MaterialPageRoute(
                builder: (context) => BookListHomePage(title: "New")));
      }
      // my book
      if (event is PressBtnMoveMyBookEvent) {
        // Navigator.push(
        //                 event.context,
        //                 MaterialPageRoute(
        //                     builder: (context) => QRPage(
        //                           data: "data",
        //                           registed: true,
        //                         ),),);
      }
      if (event is PressBtnMoveMyBookAllEvent) {
        Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => PaymentHistoryPage()));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}