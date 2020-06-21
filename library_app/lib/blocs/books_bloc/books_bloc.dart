import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/api/book/getBookCategory_api.dart';
import 'package:library_app/data/api/book/getBook_api.dart';
import 'package:library_app/data/api/bookmark/addBookmark_api.dart';
import 'package:library_app/data/api/bookmark/delBookmark_api.dart';
import 'package:library_app/data/api/bookmark/getBookmark_api.dart';
import 'package:library_app/data/api/cart/addCart_api.dart';
import 'package:library_app/data/api/cart/delCart_api.dart';
import 'package:library_app/data/api/payment/addPayment_api.dart';
import 'package:library_app/data/model/bookmarks_model.dart';
import 'package:library_app/data/model/books_model.dart';
import 'package:library_app/screens/widget/qrScreen.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final dayNow = DateTime.now().millisecondsSinceEpoch;
  final dayFinal =
      DateTime.now().add(new Duration(days: 7)).millisecondsSinceEpoch;

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
        BookmarksModel bookmarksModel = await getBookmark();
        if (bookModel?.books != null && bookmarksModel?.bookmarks != null) {
          for (var i = 0; i < bookmarksModel.bookmarks.length; i++) {
            for (var j = 0; j < bookModel.books.length; j++) {
              bookModel.books[j].name == bookmarksModel.bookmarks[i].name
                  ? bookModel.books[j].bookmark = true
                  : bookModel.books[j].bookmark == true
                      ? bookModel.books[j].bookmark = true
                      : bookModel.books[j].bookmark = false;
            }
          }
          yield LoadedBookState(bookList: bookModel.books);
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      if (event is LoadBookCategoryEvent) {
        yield LoadingState();
        BooksModel bookModel = await getBookCategory(category: event.category);
        BookmarksModel bookmarksModel = await getBookmark();
        if (bookModel?.books != null && bookmarksModel?.bookmarks != null) {
          for (var i = 0; i < bookmarksModel.bookmarks.length; i++) {
            for (var j = 0; j < bookModel.books.length; j++) {
              bookModel.books[j].name == bookmarksModel.bookmarks[i].name
                  ? bookModel.books[j].bookmark = true
                  : bookModel.books[j].bookmark == true
                      ? bookModel.books[j].bookmark = true
                      : bookModel.books[j].bookmark = false;
            }
          }
          yield LoadedBookState(bookList: bookModel.books);
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Button
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
        yield LoadingState();
        final result = await postAddCart(
            image: event.book.image,
            name: event.book.name,
            author: event.book.author,
            evaluateBook: event.book.evaluateBook,
            description: event.book.description,
            count: event.count,
            cost: event.cost,
            username: ConfigsApp.userName);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Add Cart Success");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Delete Cart
      if (event is PressButtonDelCartEvent) {
        yield LoadingState();
        final result = await postDelCart(
            name: event.book.name, username: ConfigsApp.userName);
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
            image: event.book.image,
            name: event.book.name,
            author: event.book.author,
            evaluateBook: event.book.evaluateBook,
            count: 0,
            cost: event.book.cost,
            registrationDate: dayNow,
            expirationDate: dayFinal,
            status: event.status,
            username: ConfigsApp.userName);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Add Payment Success");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Add Bookmark
      if (event is PressBookmarkEvent) {
        if (event.book.bookmark) {
          final result = await postAddBookmark(
              image: event.book.image,
              name: event.book.name,
              description: event.book.description,
              evaluateBook: event.book.evaluateBook,
              author: event.book.author,
              category: event.book.category,
              cost: event.book.cost,
              writingGenre: event.book.writingGenre,
              achievements: event.book.achievements,
              cover: event.book.cover,
              evaluateAuthor: event.book.evaluateAuthor,
              imageAuthor: event.book.imageAuthor,
              language: event.book.language,
              pages: event.book.pages);
          if (result == 1) {
            yield SuccessState(
                title: "Congratulations", message: "Add Bookmark Success");
          } else {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Error Sever");
          }
        } else {
          final result = await postDelBookmark(name: event.book.name);
          if (result == 1) {
            yield SuccessState(
                title: "Congratulations", message: "Del Bookmark Success");
          } else {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Error Sever");
          }
        }
        yield PressBookmarkState(
            bookmark: event.book.bookmark, context: event.context);
      }
      // Button
      if (event is MoveAllBookEvent) {
        yield MoveAllBookState(title: event.title);
      }
      if (event is MoveBookEvent) {
        yield MoveBookState(book: event.book);
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
