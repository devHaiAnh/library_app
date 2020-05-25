part of 'total_bloc.dart';

abstract class TotalEvent extends Equatable {
  const TotalEvent();
}

class LoadTotalEvent extends TotalEvent {
  @override
  List<Object> get props => [];
}

class OnReFreshTotalEvent extends TotalEvent {
  @override
  List<Object> get props => [];
}