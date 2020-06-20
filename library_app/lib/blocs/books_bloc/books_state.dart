part of 'books_bloc.dart';

abstract class BooksState extends Equatable {
  const BooksState();
}

class BooksInitial extends BooksState {
  @override
  List<Object> get props => [];
}

// load listview
class LoadingState extends BooksState {
  @override
  List<Object> get props => [];
}

class RefreshState extends BooksState {
  @override
  List<Object> get props => [];
}

class LoadedBookState extends BooksState {
  final List<Book> bookList;
  LoadedBookState({@required this.bookList});
  @override
  List<Object> get props => [bookList];
}

// button
class PressBookmarkState extends BooksState {
  final bool bookmark;
  final BuildContext context;
  PressBookmarkState({@required this.bookmark, @required this.context});
  @override
  List<Object> get props => [bookmark];
}

// state response

class SuccessState extends BooksState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends BooksState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorTitle];
}
