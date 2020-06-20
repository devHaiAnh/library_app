part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

// member

class PressBtnLogoutEvent extends HomeEvent {
  final BuildContext context;
  PressBtnLogoutEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class PressBtnBackEvent extends HomeEvent {
  final BuildContext context;
  PressBtnBackEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class PressBtnMoveEditEvent extends HomeEvent {
  final Member member;
  final BuildContext context;
  PressBtnMoveEditEvent({@required this.member, @required this.context});
  @override
  List<Object> get props => [member];
}

class PressBtnMoveChangePassEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveChangePassEvent({@required this.context});
  @override
  List<Object> get props => [];
}

// category
class PressBtnMoveCategoryEvent extends HomeEvent {
  final String category;
  final BuildContext context;
  PressBtnMoveCategoryEvent({@required this.context, @required this.category});
  @override
  List<Object> get props => [category];
}

class PressBtnMoveCategoryAllEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveCategoryAllEvent({@required this.context});
  @override
  List<Object> get props => [];
}

// my book
class PressBtnMoveMyBookEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveMyBookEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class PressBtnMoveMyBookAllEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveMyBookAllEvent({@required this.context});
  @override
  List<Object> get props => [];
}

// // book list
// class LoadBookEvent extends HomeEvent {
//   @override
//   List<Object> get props => [];
// }

// class OnReFreshBookEvent extends HomeEvent {
//   @override
//   List<Object> get props => [];
// }
