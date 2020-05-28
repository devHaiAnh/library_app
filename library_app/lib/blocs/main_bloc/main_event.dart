part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class CheckInternetEvent extends MainEvent {
  @override
  List<Object> get props => [];
}

class OnReFreshTotalEvent extends MainEvent {
  @override
  List<Object> get props => [];
}