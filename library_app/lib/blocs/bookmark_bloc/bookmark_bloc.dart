import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/data/api/bookmark/delBookmark_api.dart';
import 'package:library_app/data/api/bookmark/getBookmark_api.dart';
import 'package:library_app/data/api/cart/addCart_api.dart';
import 'package:library_app/data/model/bookmarks_model.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  @override
  BookmarkState get initialState => BookmarkInitial();

  @override
  Stream<BookmarkState> mapEventToState(
    BookmarkEvent event,
  ) async* {
    try {
      // Read
      if (event is LoadBookmarkEvent) {
        yield LoadingState();
        BookmarksModel bookmarkModel = await getBookmark();
        if (bookmarkModel?.bookmarks != null) {
          yield LoadedBookmarkState(bookmarkList: bookmarkModel.bookmarks);
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Delete Bookmark
      if (event is PressButtonDelBookmarkEvent) {
        yield LoadingState();
        final result = await postDelBookmark(name: event.bookmark.name);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Delete Cart Success");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Add Cart
      if (event is PressButtonAddCartEvent) {
        yield LoadingState();
        final result = await postAddCart(
            image: event.bookmark.image,
            name: event.bookmark.name,
            author: event.bookmark.author,
            evaluateBook: event.bookmark.evaluateBook,
            description: event.bookmark.description,
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
      // Button
      if (event is PressButtonBackEvent) {
        Navigator.pop(event.context);
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
