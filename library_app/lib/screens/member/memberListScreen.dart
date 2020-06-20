import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/member_bloc/member_bloc.dart';
import 'package:library_app/blocs/members_bloc/members_bloc.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/screens/member/addMemberScreen.dart';
import 'package:library_app/screens/member/editMembersScreen.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:library_app/screens/widget/itemMembers.dart';

class MemberListPage extends StatefulWidget {
  @override
  _MemberListPageState createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  final _memberBloc = MembersBloc();
  GlobalKey memberListKey = GlobalKey();

  @override
  void dispose() {
    _memberBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => _memberBloc..add(LoadMemberEvent()),
      child: BlocListener<MembersBloc, MembersState>(
        listener: (context, state) {},
        child: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            return Scaffold(
              key: memberListKey,
              body: Stack(
                children: <Widget>[
                  // background
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.grey[100],
                    ),
                  ),
                  // appbar
                  Positioned(
                      top: 0,
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      child: AppBarApp(
                        buttonBack: 0,
                        width: screenWidth,
                        height: screenHeight,
                        title: "Member List",
                      )),
                  // contain
                  Positioned(
                    top: screenHeight * 0.12,
                    left: 0,
                    right: 0,
                    bottom: screenHeight * 0.005,
                    child: containPage(screenHeight, screenWidth, state),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget containPage(
      double screenHeight, double screenWidth, MembersState state) {
    if (state is LoadedState) {
      return Container(
        height: screenHeight * 0.88,
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(40)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
              child: state.memberList.length != 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.memberList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMembersPage(
                                  member: state.memberList[index],
                                ),
                              ),
                            );
                          },
                          child: ItemMembers(
                            width: screenWidth,
                            height: screenHeight,
                            itemMember: state.memberList[index],
                            state: state.memberList[index].username ==
                                    ConfigsApp.userName
                                ? true
                                : false,
                            function: (v) {
                              v
                                  ? print("object")
                                  : BlocProvider.of<MembersBloc>(
                                          memberListKey.currentContext)
                                      .add(PressButtonDeleteEvent(
                                          context: context,
                                          username: state
                                              .memberList[index].username));
                              BlocProvider.of<MembersBloc>(
                                      memberListKey.currentContext)
                                  .add(LoadMemberEvent());
                            },
                          ),
                        );
                      },
                    )
                  : Container(
                      height: screenHeight * 0.88,
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(40)),
                    ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMemberPage(
                                function: (v) {
                                  v
                                      ? BlocProvider.of<MembersBloc>(
                                              memberListKey.currentContext)
                                          .add(LoadMemberEvent())
                                      : print("object");
                                },
                              )));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
                  decoration: BoxDecoration(
                    color: Colors.purple[400],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        height: screenHeight * 0.88,
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(40)),
      );
    }
  }
}
