part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();
}

// Read
class LoadBookEvent extends BooksEvent {
  @override
  List<Object> get props => [];
}

class OnReFreshBookEvent extends BooksEvent {
  @override
  List<Object> get props => [];
}

// button move

class PressBtnMoveBookEvent extends BooksEvent {
  final Book book;
  final BuildContext context;
  PressBtnMoveBookEvent({@required this.book, @required this.context});
  @override
  List<Object> get props => [book];
}

class PressButtonBackEvent extends BooksEvent {
  final BuildContext context;
  PressButtonBackEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class PressButtonQREvent extends BooksEvent {
  final String data;
  final bool registed;
  final BuildContext context;
  PressButtonQREvent(
      {@required this.data, @required this.registed, @required this.context});
  @override
  List<Object> get props => [data, registed];
}

// add cart
class PressButtonAddCartEvent extends BooksEvent {
  final Book book;
  final int count;
  final double cost;
  final BuildContext context;
  PressButtonAddCartEvent(
      {@required this.book,
      @required this.count,
      @required this.cost,
      @required this.context});
  @override
  List<Object> get props => [book, count, cost];
}

// delete cart
class PressButtonDelCartEvent extends BooksEvent {
  final Book book;
  final BuildContext context;
  PressButtonDelCartEvent({@required this.book, @required this.context});
  @override
  List<Object> get props => [book];
}

// add bookmark
class PressBookmarkEvent extends BooksEvent {
  final Book book;
  final bool bookmark;
  final BuildContext context;
  PressBookmarkEvent(
      {@required this.book, @required this.bookmark, @required this.context});
  @override
  List<Object> get props => [book, bookmark];
}
