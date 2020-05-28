import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/api/book/getBook_api.dart';
import 'package:library_app/data/api/bookmark/addBookmark_api.dart';
import 'package:library_app/data/api/bookmark/delBookmark_api.dart';
import 'package:library_app/data/model/books_model.dart';
import 'package:library_app/screens/book/bookScreen.dart';
import 'package:library_app/screens/widget/qrScreen.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  @override
  BooksState get initialState => BooksInitial();

  @override
  Stream<BooksState> mapEventToState(
    BooksEvent event,
  ) async* {
    try {
      // Read
      if (event is LoadBookEvent) {
        yield LoadingState();
        BooksModel bookModel = await getBook();
        if (bookModel?.books != null) {
          yield LoadedState(bookList: bookModel.books);
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Button Move
      if (event is PressBtnMoveBookEvent) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => BookPage(
              book: event.book,
            ),
          ),
        );
      }
      if (event is PressButtonBackEvent) {
        Navigator.pop(event.context);
      }
      if (event is PressButtonQREvent) {
        Navigator.pop(event.context);
        Navigator.push(
            event.context,
            MaterialPageRoute(
                builder: (context) => QRPage(
                      data: event.data,
                      registed: event.registed,
                    )));
      }
      // Add Cart
      if (event is PressButtonAddCartEvent) {
        // yield LoadingState();
        // final result = await postAddCart(
        //     username: event.username,
        //     password: event.password,
        //     name: event.name,
        //     email: event.email,
        //     phone: event.phone,
        //     admin: event.admin);
        // if (result == 1) {
        //   yield SuccessState(
        //       title: "Congratulations", message: "Add Member Success");
        // } else if (result == 2) {
        //   yield ErrorState(
        //       errorTitle: "Warning!!!", errorMessage: "Member already exists");
        // } else {
        //   yield ErrorState(
        //       errorTitle: "Warning!!!", errorMessage: "Error Sever");
        // }
      }
      // Add Bookmark
      if (event is PressBookmarkEvent) {
        if (!event.bookmark) {
          final result = await postAddBookmark(
              image: event.book.image,
              name: event.book.name,
              description: event.book.description,
              evaluateBook: event.book.evaluateBook,
              author: event.book.author);
          if (result == 1) {
          } else {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Error Sever");
          }
        } else {
          final result = await postDelBookmark(
              name: event.book.name);
          if (result == 1) {
          } else {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Error Sever");
          }
        }
        yield PressBookmarkState(
            context: event.context, bookmark: !event.bookmark);
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
