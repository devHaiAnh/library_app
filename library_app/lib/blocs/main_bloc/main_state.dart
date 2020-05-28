part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MainState{
  @override
  List<Object> get props => [];
}

class CheckedState extends MainState{
  @override
  List<Object> get props => [];
}

class ErrorState extends MainState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}