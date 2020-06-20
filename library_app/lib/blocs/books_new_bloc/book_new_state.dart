part of 'book_new_bloc.dart';

abstract class BookNewState extends Equatable {
  const BookNewState();
}

class BookNewInitial extends BookNewState {
  @override
  List<Object> get props => [];
}

// load listview
class LoadingState extends BookNewState {
  @override
  List<Object> get props => [];
}

class RefreshState extends BookNewState {
  @override
  List<Object> get props => [];
}

class LoadedBookState extends BookNewState {
  final List<Book> bookList;
  LoadedBookState({@required this.bookList});
  @override
  List<Object> get props => [bookList];
}

class SuccessState extends BookNewState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends BookNewState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorTitle];
}

class PressBookmarkState extends BookNewState {
  final bool bookmark;
  final BuildContext context;
  PressBookmarkState({@required this.bookmark, @required this.context});
  @override
  List<Object> get props => [bookmark];
}