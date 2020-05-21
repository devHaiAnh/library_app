part of 'forgot_pass_bloc.dart';

abstract class ForgotPassState extends Equatable {
  const ForgotPassState();
}

class ForgotPassInitial extends ForgotPassState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ForgotPassState {
  @override
  List<Object> get props => [];
}

class SuccessState extends ForgotPassState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends ForgotPassState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}
