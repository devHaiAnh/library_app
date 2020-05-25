part of 'member_bloc.dart';

abstract class MemberState extends Equatable {
  const MemberState();
}

class MemberInitial extends MemberState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MemberState {
  @override
  List<Object> get props => [];
}

class RefreshState extends MemberState {
  @override
  List<Object> get props => [];
}

class LoadedState extends MemberState {
  final List<Member> memberList;
  LoadedState({@required this.memberList});
  @override
  List<Object> get props => [memberList];
}

class SuccessState extends MemberState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ShowPasswordOldState extends MemberState {
  final bool showPass;
  ShowPasswordOldState({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class ShowPasswordNewState extends MemberState {
  final bool showPass;
  ShowPasswordNewState({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class ShowPasswordRetypeState extends MemberState {
  final bool showPass;
  ShowPasswordRetypeState({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class CheckAdminState extends MemberState {
  final bool admin;
  CheckAdminState({@required this.admin});
  @override
  List<Object> get props => [admin];
}

class ErrorState extends MemberState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorTitle];
}
