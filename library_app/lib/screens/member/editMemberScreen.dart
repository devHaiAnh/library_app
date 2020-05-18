import 'package:flutter/material.dart';
import 'package:library_app/data/model/member.dart';

class EditMemberPage extends StatefulWidget {
  final Member member;
  EditMemberPage({Key key, this.member}) : super(key: key);

  @override
  _EditMemberPageState createState() => _EditMemberPageState();
}

class _EditMemberPageState extends State<EditMemberPage> {
  bool typeAdmin = false;
  TextEditingController _name;
  TextEditingController _email;
  TextEditingController _phone;
  @override
  void initState() {
    _name = TextEditingController(text: widget.member.name);
    _email = TextEditingController(text: widget.member.email);
    _phone = TextEditingController(text: widget.member.phone);
    typeAdmin = widget.member.admin;
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
                      child: Container(
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
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
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 18,
                          )),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
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
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            Icons.done,
                            size: 18,
                            color: Colors.purple,
                          )),
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
                  image: AssetImage(widget.member.admin
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
            child: Container(),
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
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Phone",
              prefixIcon: Icon(Icons.phone),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
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
                        fontSize: 16,
                        color: Colors.purple[400],
                      ),
                    ),
                    Container(
                      width: screenHeight * 0.04,
                      height: screenHeight * 0.04,
                      child: Icon(
                        typeAdmin
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: Colors.purple[400],
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
            color: Colors.purple[400],
          ),
        ),
      ),
    );
  }
}
