import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  @override
  BookmarkState get initialState => BookmarkInitial();

  @override
  Stream<BookmarkState> mapEventToState(
    BookmarkEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
