import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/model/books_model.dart';
import 'package:library_app/data/model/login_model.dart';
import 'package:library_app/screens/book/bookScreen.dart';
import 'package:library_app/screens/home/bookListHome.dart';
import 'package:library_app/screens/home/categoryBookHome.dart';
import 'package:library_app/screens/home/categoryListHome.dart';
import 'package:library_app/screens/login_register_forgot/signinScreen.dart';
import 'package:library_app/screens/member/changePasswordScreen.dart';
import 'package:library_app/screens/member/editMemberScreen.dart';
import 'package:library_app/screens/payment/paymentHistoryMemberScreen.dart';
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
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
        );
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
            ),
          ),
        );
      }
      if (event is PressBtnMoveChangePassEvent) {
        Navigator.pop(event.context);
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => ChangePasswordPage(),
          ),
        );
      }
      // category
      // if (event is PressBtnMoveCategoryEvent) {
      //   Navigator.push(
      //     event.context,
      //     MaterialPageRoute(
      //       builder: (context) =>
      //           CategoryBookHomePage(category: event.category),
      //     ),
      //   );
      // }
      // if (event is PressBtnMoveCategoryAllEvent) {
      //   Navigator.push(
      //     event.context,
      //     MaterialPageRoute(
      //       builder: (context) => CategoryListHomePage(),
      //     ),
      //   );
      // }
      // my book
      // if (event is PressBtnMoveMyBookEvent) {
      //   Navigator.push(
      //     event.context,
      //     MaterialPageRoute(
      //       builder: (context) => QRPage(
      //         data: "data",
      //         registed: true,
      //       ),
      //     ),
      //   );
      // }
      // if (event is PressBtnMoveMyBookAllEvent) {
      //   Navigator.push(
      //     event.context,
      //     MaterialPageRoute(
      //       builder: (context) => PaymentHistoryMemberPage(
      //         username: ConfigsApp.userName,
      //       ),
      //     ),
      //   );
      // }
      // // Read
      // if (event is LoadBookEvent) {
      //   yield LoadingState();
      //   BooksModel bookModel = await getBook();
      //   if (bookModel?.books != null) {
      //     yield LoadedState(bookList: bookModel.books);
      //   } else {
      //     yield ErrorState(
      //         errorTitle: "Warning!!!", errorMessage: "Error Sever");
      //   }
      // }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
