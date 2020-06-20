part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();
}

// Read
class LoadBookmarkEvent extends BookmarkEvent {
  @override
  List<Object> get props => [];
}

class OnReFreshBookmarkEvent extends BookmarkEvent {
  @override
  List<Object> get props => [];
}
// delete bookmark
class PressButtonDelBookmarkEvent extends BookmarkEvent {
  final Bookmark bookmark;
  final BuildContext context;
  PressButtonDelBookmarkEvent({@required this.bookmark, @required this.context});
  @override
  List<Object> get props => [bookmark];
}

// Add Cart
class PressButtonAddCartEvent extends BookmarkEvent {
  final Bookmark bookmark;
  final int count;
  final double cost;
  final BuildContext context;
  PressButtonAddCartEvent(
      {@required this.bookmark,
      @required this.count,
      @required this.cost,
      @required this.context});
  @override
  List<Object> get props => [bookmark, count, cost];
}

// Button 
class PressButtonBackEvent extends BookmarkEvent {
  final BuildContext context;
  PressButtonBackEvent({@required this.context});
  @override
  List<Object> get props => [];
}