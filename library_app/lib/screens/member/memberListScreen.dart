import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/blocs/members_bloc/members_bloc.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/screens/member/addMemberScreen.dart';
import 'package:library_app/screens/member/editMembersScreen.dart';
import 'package:library_app/screens/payment/paymentHistoryMemberScreen.dart';
import 'package:library_app/screens/widget/appbarApp.dart';

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
                          child:
                              // ItemMembers(
                              //   width: screenWidth,
                              //   height: screenHeight,
                              //   itemMember: state.memberList[index],
                              //   state:
                              //       state.memberList[index].username == ConfigsApp.userName
                              //           ? true
                              //           : false,
                              // ),
                              Container(
                            height: screenHeight * 0.25,
                            padding: EdgeInsets.all(screenWidth * 0.025),
                            margin: EdgeInsets.all(screenWidth * 0.02),
                            width: screenWidth * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: <Widget>[
                                // image
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      width: screenWidth * 0.01,
                                      height: screenHeight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                            state.memberList[index].admin
                                                ? "assets/img/admin.png"
                                                : "assets/img/member.png",
                                            height: screenHeight * 0.1,
                                            color: state.memberList[index].admin
                                                ? Colors.black87
                                                : Colors.black54),
                                      )),
                                ),
                                // contain
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.025),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        // name / author + delete
                                        Container(
                                          width: screenWidth,
                                          height: screenHeight * 0.05,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 12,
                                                child: Container(
                                                  child: Text(
                                                    state.memberList[index]
                                                        .username,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PaymentHistoryMemberPage(
                                                          username: state
                                                              .memberList[index]
                                                              .username,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.07,
                                                    height: screenWidth * 0.07,
                                                    child: Center(
                                                      child: FaIcon(
                                                          FontAwesomeIcons
                                                              .cartArrowDown,
                                                          color: Colors
                                                              .purple[300],
                                                          size: 20),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.02),
                                              state.memberList[index]
                                                          .username ==
                                                      ConfigsApp.userName
                                                  ? Container()
                                                  : Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () {
                                                          BlocProvider.of<
                                                                      MembersBloc>(
                                                                  memberListKey
                                                                      .currentContext)
                                                              .add(PressButtonDeleteEvent(
                                                                  username: state
                                                                      .memberList[
                                                                          index]
                                                                      .username,
                                                                  context:
                                                                      context));
                                                          BlocProvider.of<
                                                                      MembersBloc>(
                                                                  memberListKey
                                                                      .currentContext)
                                                              .add(
                                                                  LoadMemberEvent());
                                                        },
                                                        child: Container(
                                                          width: screenWidth *
                                                              0.07,
                                                          height: screenWidth *
                                                              0.07,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .red),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24)),
                                                          child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //     height: screenHeight * 0.005),
                                        Container(
                                          height: screenHeight * 0.02,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Full name: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                TextSpan(
                                                  text: state
                                                      .memberList[index].name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: screenHeight * 0.02,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Email: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                TextSpan(
                                                  text: state
                                                      .memberList[index].email,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: screenHeight * 0.02,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Phone: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                TextSpan(
                                                  text: state
                                                      .memberList[index].phone,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: screenHeight * 0.02,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Type: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                TextSpan(
                                                  text: state.memberList[index]
                                                              .admin ==
                                                          true
                                                      ? "Admin"
                                                      : "Member",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddMemberPage()));
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
      return Scaffold(
        body: Container(),
      );
    }
  }
}
