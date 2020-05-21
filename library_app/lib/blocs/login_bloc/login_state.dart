part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class SuccessState extends LoginState {
  @override
  List<Object> get props => [];
}

class SavePasswordState extends LoginState {
  final bool savePass;
  SavePasswordState({@required this.savePass});
  @override
  List<Object> get props => [savePass];
}

class ShowPasswordState extends LoginState {
  final bool showPass;
  ShowPasswordState({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class ErrorState extends LoginState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}
