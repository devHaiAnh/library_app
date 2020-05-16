import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/model/member.dart';
import 'package:library_app/screens/memberScreen.dart';
import 'package:library_app/screens/paymentHistoryScreen.dart';
import 'package:library_app/screens/widget/appbarApp.dart';

class MemberListPage extends StatefulWidget {
  @override
  _MemberListPageState createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  String you = " (you)";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
            child: containPage(screenHeight, screenWidth),
          )
        ],
      ),
    );
  }

  Widget containPage(double screenHeight, double screenWidth) {
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
      child: memberList.length != 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: memberList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MemberPage(member: memberList[index])));
                  },
                  child: itemMember(screenHeight, screenWidth, index, context),
                );
              },
            )
          : Container(
              child: Center(
                child: Text("/* No Data */"),
              ),
            ),
    );
  }

  Widget itemMember(double screenHeight, double screenWidth, int index,
      BuildContext context) {
    return Container(
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
            offset: Offset(0, 3), // changes position of shadow
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
                // color: Colors.indigoAccent,
                // width: screenWidth*0.01,
                // height: screenHeight,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(32),
                //   color: Colors.red
                // ),
                child: Center(
              child: Image.asset(
                  memberList[index].type
                      ? "assets/img/admin.png"
                      : "assets/img/member.png",
                  height: screenHeight * 0.1,
                  color: memberList[index].type
                      ? Colors.purple[400]
                      : Colors.black54),
            )),
          ),
          // contain
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(left: screenWidth * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // name / author + delete
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.05,
                    // color: Colors.red,

                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 12,
                          child: Container(
                            child: Text(
                              memberList[index].username + you,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
                                          PaymentHistoryPage()));
                            },
                            child: Container(
                              width: screenWidth * 0.07,
                              height: screenWidth * 0.07,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         color:
                              //             Colors.red),
                              //     borderRadius:
                              //         BorderRadius
                              //             .circular(
                              //                 24)),
                              child: Center(
                                child: FaIcon(FontAwesomeIcons.cartArrowDown,
                                    color: Colors.purple, size: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                // memberList[index]
                                //         .bookMark =
                                //     !memberList[index]
                                //         .bookMark;
                              });
                            },
                            child: Container(
                              width: screenWidth * 0.07,
                              height: screenWidth * 0.07,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(24)),
                              child: Icon(Icons.close, color: Colors.red),
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
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: memberList[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
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
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: memberList[index].email,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
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
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: memberList[index].phone,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
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
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: memberList[index].type == true
                                ? "Admin"
                                : "Member",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
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
    );
  }
}
