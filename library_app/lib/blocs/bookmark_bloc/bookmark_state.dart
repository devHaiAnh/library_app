part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();
}

class BookmarkInitial extends BookmarkState {
  @override
  List<Object> get props => [];
}

// load listview
class LoadingState extends BookmarkState {
  @override
  List<Object> get props => [];
}

class RefreshState extends BookmarkState {
  @override
  List<Object> get props => [];
}

class LoadedBookmarkState extends BookmarkState {
  final List<Bookmark> bookmarkList;
  LoadedBookmarkState({@required this.bookmarkList});
  @override
  List<Object> get props => [bookmarkList];
}

class SuccessState extends BookmarkState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends BookmarkState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}


