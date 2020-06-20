part of 'book_trending_bloc.dart';

abstract class BookTrendingState extends Equatable {
  const BookTrendingState();
}

class BookTrendingInitial extends BookTrendingState {
  @override
  List<Object> get props => [];
}

// load listview
class LoadingState extends BookTrendingState {
  @override
  List<Object> get props => [];
}

class RefreshState extends BookTrendingState {
  @override
  List<Object> get props => [];
}

class LoadedBookState extends BookTrendingState {
  final List<Book> bookList;
  LoadedBookState({@required this.bookList});
  @override
  List<Object> get props => [bookList];
}

class SuccessState extends BookTrendingState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends BookTrendingState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorTitle];
}

class PressBookmarkState extends BookTrendingState {
  final bool bookmark;
  final BuildContext context;
  PressBookmarkState({@required this.bookmark, @required this.context});
  @override
  List<Object> get props => [bookmark];
}