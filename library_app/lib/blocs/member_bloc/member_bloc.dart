import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/api/member/updateMember_api.dart';
import 'package:library_app/data/api/member/updatePass_api.dart';
import 'package:library_app/data/model/login_model.dart';
import 'package:library_app/screens/totalScreen.dart';
import 'package:library_app/streams/changePass_stream.dart';
import 'package:library_app/streams/updateMember_stream.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  @override
  MemberState get initialState => MemberInitial();

  @override
  Stream<MemberState> mapEventToState(
    MemberEvent event,
  ) async* {
    try {
      if (event is PressButtonUpdateMemberEvent) {
        yield LoadingState();
        // if (event.updateMemberStream.isValidInfo(
        //     name: event.name, email: event.email, phone: event.phone)) {
        final result = await postUpdateMember(
            name: event.name, phone: event.phone, email: event.email);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Update Member Success");
          event.member.name = event.name;
          event.member.phone = event.phone;
          event.member.email = event.email;
          Navigator.push(
              event.context,
              MaterialPageRoute(
                  builder: (context) => TotalPage(member: event.member)));
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
        // } else {
        //   yield ErrorState(
        //       errorTitle: "Warning!!!",
        //       errorMessage: "The data entered is not in the correct format");
        // }
      }
      // Change password
      if (event is ChangePasswordEvent) {
        yield LoadingState();
        // if (event.changePassStream.isValidInfo(
        //     passwordOld: event.passOld,
        //     passwordNew: event.passNew,
        //     repassword: event.passRetype)) {
        final result = await postUpdatePass(password: event.passRetype);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Change Password Success");
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
        // } else {
        //   yield ErrorState(
        //       errorTitle: "Warning!!!",
        //       errorMessage: "The data entered is not in the correct format");
        // }
      }
      if (event is ShowPasswordOldEvent) {
        yield ShowPasswordOldState(showPass: !event.showPass);
      }
      if (event is ShowPasswordNewEvent) {
        yield ShowPasswordNewState(showPass: !event.showPass);
      }
      if (event is ShowPasswordRetypeEvent) {
        yield ShowPasswordRetypeState(showPass: !event.showPass);
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
