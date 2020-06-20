part of 'book_trending_bloc.dart';

abstract class BookTrendingEvent extends Equatable {
  const BookTrendingEvent();
}

class LoadBookCategoryEvent extends BookTrendingEvent {
  final String category;
  LoadBookCategoryEvent({@required this.category});
  @override
  List<Object> get props => [category];
}

class OnReFreshBookEvent extends BookTrendingEvent {
  @override
  List<Object> get props => [];
}

// add bookmark
class PressBookmarkEvent extends BookTrendingEvent {
  final Book book;
  final BuildContext context;
  PressBookmarkEvent(
      {@required this.book, @required this.context});
  @override
  List<Object> get props => [book];
}