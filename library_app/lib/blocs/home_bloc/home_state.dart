part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

// class RefreshState extends HomeState {
//   @override
//   List<Object> get props => [];
// }

// class LoadedState extends HomeState {
//   final List<Book> bookList;
//   LoadedState({@required this.bookList});
//   @override
//   List<Object> get props => [bookList];
// }

class SuccessState extends HomeState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends HomeState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}
