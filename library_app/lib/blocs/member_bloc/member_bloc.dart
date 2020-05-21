import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  @override
  MemberState get initialState => MemberInitial();

  @override
  Stream<MemberState> mapEventToState(
    MemberEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
