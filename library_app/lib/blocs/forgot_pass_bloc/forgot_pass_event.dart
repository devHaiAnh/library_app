part of 'forgot_pass_bloc.dart';

class ForgotPassEvent extends Equatable {
  const ForgotPassEvent();

  @override
  List<Object> get props => [];
}
class PressButtonForgotPassEvent extends ForgotPassEvent {
  final String username;
  final String passowrd;
  final String email;
  final BuildContext context;
  final ForgotPassStream forgotPassStream;
  PressButtonForgotPassEvent(
      {@required this.username,
      @required this.passowrd,
      @required this.email,
      @required this.context,
      this.forgotPassStream});
  @override
  List<Object> get props => [username, passowrd, email];
}

class ShowPasswordEvent extends ForgotPassEvent {
  final bool showPass;
  ShowPasswordEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class ShowPasswordRetypeEvent extends ForgotPassEvent {
  final bool showPass;
  ShowPasswordRetypeEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}