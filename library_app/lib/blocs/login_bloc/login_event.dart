part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PressButtonLoginEvent extends LoginEvent {
  final String username;
  final String passowrd;
  final BuildContext context;
  final LoginStream loginStream;
  PressButtonLoginEvent(
      {@required this.username,
      @required this.passowrd,
      @required this.context,
      this.loginStream});
  @override
  List<Object> get props => [username, passowrd];
}

class PressButtonMoveForgotEvent extends LoginEvent {
  final BuildContext context;
  PressButtonMoveForgotEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class PressButtonMoveRegisterEvent extends LoginEvent {
  final BuildContext context;
  PressButtonMoveRegisterEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class SavePasswordEvent extends LoginEvent {
  final bool savePass;
  SavePasswordEvent({@required this.savePass});
  @override
  List<Object> get props => [savePass];
}

class ShowPasswordEvent extends LoginEvent {
  final bool showPass;
  ShowPasswordEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}
