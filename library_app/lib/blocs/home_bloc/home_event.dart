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
  PressBtnMoveEditEvent({@required this.member ,@required this.context});
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
  final BuildContext context;
  PressBtnMoveCategoryEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class PressBtnMoveCategoryAllEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveCategoryAllEvent({@required this.context});
  @override
  List<Object> get props => [];
}

// trending
class PressBtnMoveTrendingEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveTrendingEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class PressBtnMoveTrendingAllEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveTrendingAllEvent({@required this.context});
  @override
  List<Object> get props => [];
}

// new book
class PressBtnMoveNewBookEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveNewBookEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class PressBtnMoveNewBookAllEvent extends HomeEvent {
  final BuildContext context;
  PressBtnMoveNewBookAllEvent({@required this.context});
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
