import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/data/model/member.dart';
import 'package:library_app/screens/member/paymentHistoryScreen.dart';

class ItemMember extends StatefulWidget {
  final double width, height;
  final Member itemMember;
  final bool state;
  ItemMember({Key key, this.width, this.height, this.itemMember, this.state})
      : super(key: key);
  @override
  _ItemMemberState createState() => _ItemMemberState();
}

class _ItemMemberState extends State<ItemMember> {
  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.25,
      padding: EdgeInsets.all(widget.width * 0.025),
      margin: EdgeInsets.all(widget.width * 0.02),
      width: widget.width * 0.7,
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
                // width: widget.width*0.01,
                // height: widget.height,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(32),
                //   color: Colors.red
                // ),
                child: Center(
              child: Image.asset(
                  widget.itemMember.type
                      ? "assets/img/admin.png"
                      : "assets/img/member.png",
                  height: widget.height * 0.1,
                  color:
                      widget.itemMember.type ? Colors.black87 : Colors.black54),
            )),
          ),
          // contain
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(left: widget.width * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // name / author + delete
                  Container(
                    width: widget.width,
                    height: widget.height * 0.05,
                    // color: Colors.red,

                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 12,
                          child: Container(
                            child: Text(
                              widget.itemMember.username,
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
                              width: widget.width * 0.07,
                              height: widget.width * 0.07,
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
                                    color: Colors.purple[300], size: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: widget.width * 0.02),
                        widget.state
                            ? Container()
                            : Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      // widget.itemMember
                                      //         .bookMark =
                                      //     !widget.itemMember
                                      //         .bookMark;
                                    });
                                  },
                                  child: Container(
                                    width: widget.width * 0.07,
                                    height: widget.width * 0.07,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Icon(Icons.close, color: Colors.red),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //     height: widget.height * 0.005),
                  Container(
                    height: widget.height * 0.02,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Full name: ",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: widget.itemMember.name,
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
                    height: widget.height * 0.02,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Email: ",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: widget.itemMember.email,
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
                    height: widget.height * 0.02,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Phone: ",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: widget.itemMember.phone,
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
                    height: widget.height * 0.02,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Type: ",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: widget.itemMember.type == true
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
