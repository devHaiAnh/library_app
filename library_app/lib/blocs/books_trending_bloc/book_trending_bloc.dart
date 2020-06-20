import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/api/book/getBookCategory_api.dart';
import 'package:library_app/data/api/bookmark/addBookmark_api.dart';
import 'package:library_app/data/api/bookmark/delBookmark_api.dart';
import 'package:library_app/data/api/bookmark/getBookmark_api.dart';
import 'package:library_app/data/model/bookmarks_model.dart';
import 'package:library_app/data/model/books_trending.dart';

part 'book_trending_event.dart';
part 'book_trending_state.dart';

class BookTrendingBloc extends Bloc<BookTrendingEvent, BookTrendingState> {
  @override
  BookTrendingState get initialState => BookTrendingInitial();

  @override
  Stream<BookTrendingState> mapEventToState(
    BookTrendingEvent event,
  ) async* {
    try {
      if (event is LoadBookCategoryEvent) {
        yield LoadingState();
        BooksTrending bookModel =
            await getBookCategory(category: event.category);
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
          } else {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Error Sever");
          }
        } else {
          final result = await postDelBookmark(name: event.book.name);
          if (result == 1) {
          } else {
            yield ErrorState(
                errorTitle: "Warning!!!", errorMessage: "Error Sever");
          }
        }
        yield PressBookmarkState(
            bookmark: event.book.bookmark, context: event.context);
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
