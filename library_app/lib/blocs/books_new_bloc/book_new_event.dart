part of 'book_new_bloc.dart';

abstract class BookNewEvent extends Equatable {
  const BookNewEvent();
}

class LoadBookCategoryEvent extends BookNewEvent {
  final String category;
  LoadBookCategoryEvent({@required this.category});
  @override
  List<Object> get props => [category];
}

class OnReFreshBookEvent extends BookNewEvent {
  @override
  List<Object> get props => [];
}

// add bookmark
class PressBookmarkEvent extends BookNewEvent {
  final Book book;
  final BuildContext context;
  PressBookmarkEvent(
      {@required this.book, @required this.context});
  @override
  List<Object> get props => [book];
}