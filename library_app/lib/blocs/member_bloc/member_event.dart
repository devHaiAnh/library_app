part of 'member_bloc.dart';

abstract class MemberEvent extends Equatable {
  const MemberEvent();
}

class PressButtonUpdateMemberEvent extends MemberEvent {
  final String name;
  final String email;
  final String phone;
  final BuildContext context;
  final Member member;
  final UpdateMemberStream updateMemberStream;
  PressButtonUpdateMemberEvent(
      {@required this.name,
      @required this.email,
      @required this.phone,
      @required this.context,
      @required this.member,
      this.updateMemberStream});
  @override
  List<Object> get props => [name, email, phone, member, updateMemberStream];
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
