part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PressButtonRegisterEvent extends RegisterEvent {
  final String username;
  final String passowrd;
  final String email;
  final BuildContext context;
  final RegisterStream registerStream;
  PressButtonRegisterEvent(
      {@required this.username,
      @required this.passowrd,
      @required this.email,
      @required this.context,
      this.registerStream});
  @override
  List<Object> get props => [username, passowrd, email];
}

class PressButtonMoveLoginEvent extends RegisterEvent {
  final BuildContext context;
  PressButtonMoveLoginEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class ShowPasswordEvent extends RegisterEvent {
  final bool showPass;
  ShowPasswordEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}
