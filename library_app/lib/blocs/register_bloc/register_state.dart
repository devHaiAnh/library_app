part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class SuccessState extends RegisterState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ShowPasswordState extends RegisterState {
  final bool showPass;
  ShowPasswordState({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class ErrorState extends RegisterState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}
