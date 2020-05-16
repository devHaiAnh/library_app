import 'package:flutter/material.dart';
import 'package:library_app/model/member.dart';

class MemberPage extends StatefulWidget {
  final Member member;
  MemberPage({Key key, this.member}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  bool typeAdmin = false;
  TextEditingController _name;
  TextEditingController _email;
  TextEditingController _phone;
  @override
  void initState() {
    _name = TextEditingController(text: widget.member.name);
    _email = TextEditingController(text: widget.member.email);
    _phone = TextEditingController(text: widget.member.phone);
    typeAdmin = widget.member.type;
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

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
            child: SafeArea(
              top: true,
              left: true,
              right: true,
              child: Container(
                height: screenHeight * 0.08,
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.done, color: Colors.purple),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // contain
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: containPage(screenHeight, screenWidth),
          ),
          // image book
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.35,
            right: screenWidth * 0.35,
            child: Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(widget.member.type == true
                      ? "assets/img/admin.png"
                      : "assets/img/member.png"),
                  // fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget containPage(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.8,
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                setState(() {
                  // widget.book.bookMark = !widget.book.bookMark;
                });
              },
              child: Container(
                child: Align(
                  alignment: Alignment.topRight,
                  // child: Icon(
                  //     widget.book.bookMark
                  //         ? Icons.bookmark
                  //         : Icons.bookmark_border,
                  //     color: widget.book.bookMark
                  //         ? Colors.amber
                  //         : Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // username
                  username(screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  Divider(thickness: 1),
                  SizedBox(height: screenHeight * 0.01),

                  data(screenWidth, screenHeight)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget data(double screenWidth, double screenHeight) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _name,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Full name",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.vpn_key),
            ),
          ),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Phone",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                typeAdmin = !typeAdmin;
              });
            },
            child: Container(
                height: screenHeight * 0.05,
                child: Row(
                  // mainAxisAlignment:
                  //     MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Admin",
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                    Container(
                      width: screenHeight * 0.04,
                      height: screenHeight * 0.04,
                      child: Icon(
                        typeAdmin
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: Colors.purple,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget username(double screenWidth) {
    return Container(
      width: screenWidth,
      child: Center(
        child: Text(
          widget.member.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
