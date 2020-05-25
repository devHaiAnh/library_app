part of 'member_bloc.dart';

abstract class MemberEvent extends Equatable {
  const MemberEvent();
}

// Read
class LoadMemberEvent extends MemberEvent {
  @override
  List<Object> get props => [];
}

class OnReFreshMemberEvent extends MemberEvent {
  @override
  List<Object> get props => [];
}

// Create
class PressButtonAddEvent extends MemberEvent {
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

class CheckAdminEvent extends MemberEvent {
  final bool admin;
  CheckAdminEvent({@required this.admin});
  @override
  List<Object> get props => [admin];
}

// Update
class PressButtonUpdateEvent extends MemberEvent {
  final String name;
  final String email;
  final String phone;
  final bool admin;
  final BuildContext context;
  final UpdateMemberStream updateMemberStream;
  PressButtonUpdateEvent(
      {@required this.name,
      @required this.email,
      @required this.phone,
      @required this.admin,
      @required this.context,
      this.updateMemberStream});
  @override
  List<Object> get props => [name, email, phone, admin, updateMemberStream];
}

class PressButtonUpdateMemberEvent extends MemberEvent {
  final String name;
  final String email;
  final String phone;
  final BuildContext context;
  final UpdateMemberStream updateMemberStream;
  PressButtonUpdateMemberEvent(
      {@required this.name,
      @required this.email,
      @required this.phone,
      @required this.context,
      this.updateMemberStream});
  @override
  List<Object> get props => [name, email, phone, updateMemberStream];
}

class ChangePasswordEvent extends MemberEvent {
  final String passOld;
  final String passNew;
  final String passRetype;
  final BuildContext context;
  final ChangePassStream changePassStream;
  ChangePasswordEvent(
      {@required this.passOld,
      @required this.passNew,
      @required this.passRetype,
      @required this.context,
      this.changePassStream});
  @override
  List<Object> get props => [passOld, passNew, passRetype];
}

class ShowPasswordOldEvent extends MemberEvent {
  final bool showPass;
  ShowPasswordOldEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class ShowPasswordNewEvent extends MemberEvent {
  final bool showPass;
  ShowPasswordNewEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class ShowPasswordRetypeEvent extends MemberEvent {
  final bool showPass;
  ShowPasswordRetypeEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

// Delete
class PressButtonDeleteEvent extends MemberEvent {
  final String username;
  final BuildContext context;
  PressButtonDeleteEvent({@required this.username, @required this.context});
  @override
  List<Object> get props => [username, context];
}
