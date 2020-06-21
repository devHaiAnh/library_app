import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/api/member/addMember_api.dart';
import 'package:library_app/data/api/member/delMember_api.dart';
import 'package:library_app/data/api/member/getMember_api.dart';
import 'package:library_app/data/api/member/updateMembers_api.dart';
import 'package:library_app/data/model/members_model.dart';
import 'package:library_app/streams/addMember_stream.dart';
import 'package:library_app/streams/updateMember_stream.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  @override
  MembersState get initialState => MembersInitial();

  @override
  Stream<MembersState> mapEventToState(
    MembersEvent event,
  ) async* {
    try {
      // Read
      if (event is LoadMemberEvent) {
        yield LoadingState();
        MembersModel memberModel = await getMember();
        if (memberModel?.members != null) {
          yield LoadedState(memberList: memberModel.members);
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Create
      if (event is PressButtonAddEvent) {
        yield LoadingState();
        // if (event.addMemberStream.isValidInfo(
        //     username: event.username,
        //     password: event.password,
        //     name: event.name,
        //     email: event.email,
        //     address: event.address)) {
        final result = await postAddMember(
            username: event.username,
            password: event.password,
            name: event.name,
            email: event.email,
            address: event.address,
            admin: event.admin);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Add Member Success");
        } else if (result == 2) {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Member already exists");
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
      // Update
      if (event is PressButtonUpdateEvent) {
        yield LoadingState();
        // if (event.updateMemberStream.isValidInfo(
        //     name: event.name, email: event.email, address: event.address)) {
        final result = await postUpdateMembers(
            username: event.username,
            name: event.name,
            address: event.address,
            email: event.email,
            admin: event.admin);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Update Member Success");
          Navigator.pop(event.context);
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
      if (event is CheckAdminEvent) {
        yield CheckAdminState(admin: !event.admin);
      }
      if (event is ShowPasswordOldEvent) {
        yield ShowPasswordOldState(showPass: !event.showPass);
      }
      // Delete
      if (event is PressButtonDeleteEvent) {
        final result = await postDelMember(username: event.username);
        if (result == 1) {
          yield SuccessState(
              title: "Congratulations", message: "Delete Member Success");
          // Navigator.push(event.context, MaterialPageRoute(builder: (context)=> ));
        } else {
          yield ErrorState(
              errorTitle: "Warning!!!", errorMessage: "Error Sever");
        }
      }
      // Button
      if (event is MoveMemberEvent) {
        yield MoveMemberState(member: event.member);
      }
      if (event is MoveAddMemberEvent) {
        yield MoveAddMemberState();
      }
    } catch (e) {
      print("error: ${e.toString()}");
      yield ErrorState(errorTitle: "Warning!!!", errorMessage: "Error 404");
    }
  }
}
