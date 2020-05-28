part of 'members_bloc.dart';

abstract class MembersState extends Equatable {
  const MembersState();
}

class MembersInitial extends MembersState {
  @override
  List<Object> get props => [];
}


class MemberInitial extends MembersState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MembersState {
  @override
  List<Object> get props => [];
}

class RefreshState extends MembersState {
  @override
  List<Object> get props => [];
}

class LoadedState extends MembersState {
  final List<Member> memberList;
  LoadedState({@required this.memberList});
  @override
  List<Object> get props => [memberList];
}

class SuccessState extends MembersState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ShowPasswordOldState extends MembersState {
  final bool showPass;
  ShowPasswordOldState({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}

class CheckAdminState extends MembersState {
  final bool admin;
  CheckAdminState({@required this.admin});
  @override
  List<Object> get props => [admin];
}

class ErrorState extends MembersState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorTitle];
}
