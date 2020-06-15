part of 'members_bloc.dart';

abstract class MembersEvent extends Equatable {
  const MembersEvent();
}

// Read
class LoadMemberEvent extends MembersEvent {
  @override
  List<Object> get props => [];
}

class OnReFreshMemberEvent extends MembersEvent {
  @override
  List<Object> get props => [];
}

// Create
class PressButtonAddEvent extends MembersEvent {
  final String username;
  final String password;
  final String name;
  final String email;
  final String phone;
  final bool admin;
  final BuildContext context;
  final AddMemberStream addMemberStream;

  PressButtonAddEvent(
      {@required this.username,
      @required this.password,
      @required this.name,
      @required this.email,
      @required this.phone,
      @required this.admin,
      @required this.context,
      this.addMemberStream});
  @override
  List<Object> get props =>
      [name, username, password, name, email, phone, admin, addMemberStream];
}

class CheckAdminEvent extends MembersEvent {
  final bool admin;
  CheckAdminEvent({@required this.admin});
  @override
  List<Object> get props => [admin];
}

// Update
class PressButtonUpdateEvent extends MembersEvent {
  final String username;
  final String name;
  final String email;
  final String phone;
  final bool admin;
  final BuildContext context;
  final UpdateMemberStream updateMemberStream;
  PressButtonUpdateEvent(
      {@required this.username,@required this.name,
      @required this.email,
      @required this.phone,
      @required this.admin,
      @required this.context,
      this.updateMemberStream});
  @override
  List<Object> get props => [username, name, email, phone, admin];
}

class ShowPasswordOldEvent extends MembersEvent {
  final bool showPass;
  ShowPasswordOldEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

// Delete
class PressButtonDeleteEvent extends MembersEvent {
  final String username;
  final BuildContext context;
  PressButtonDeleteEvent({@required this.username, @required this.context});
  @override
  List<Object> get props => [username, context];
}
