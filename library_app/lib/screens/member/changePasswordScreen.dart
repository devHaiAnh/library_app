import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool hideOldPass = true;
  bool hideNewPass = true;
  bool hideRetypePass = true;

  TextEditingController _oldPassword;
  TextEditingController _newPassword;
  TextEditingController _retypePassword;
  @override
  void initState() {
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
    _retypePassword = TextEditingController();
    // typeAdmin = widget.member.type;
    super.initState();
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _retypePassword.dispose();
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
              child: appBar(screenHeight, context, screenWidth),
            ),
          ),
          // contain
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: containPage(screenHeight, screenWidth),
          ),
        ],
      ),
    );
  }

  Widget appBar(double screenHeight, BuildContext context, double screenWidth) {
    return Container(
      height: screenHeight * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.close,
                  size: 18,
                )),
          ),
          Container(
            height: screenHeight * 0.06,
            width: screenWidth * 0.4,
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
            child: Center(
              child: Text(
                "Change Password",
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
                      offset: Offset(0, 3), // changes position of shadow
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[data(screenWidth, screenHeight)],
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
          SizedBox(height: screenHeight * 0.1),
          TextField(
            controller: _oldPassword,
            keyboardType: TextInputType.text,
            obscureText: hideOldPass,
            decoration: InputDecoration(
              labelText: "Old password",
              prefixIcon: Icon(Icons.lock_outline),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              suffixIcon: IconButton(
                icon:
                    Icon(hideOldPass ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      hideOldPass = !hideOldPass;
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          TextField(
            controller: _newPassword,
            keyboardType: TextInputType.text,
            obscureText: hideNewPass,
            decoration: InputDecoration(
              labelText: "New password",
              prefixIcon: Icon(Icons.lock),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              suffixIcon: IconButton(
                icon:
                    Icon(hideNewPass ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      hideNewPass = !hideNewPass;
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          TextField(
            controller: _retypePassword,
            keyboardType: TextInputType.phone,
            obscureText: hideRetypePass,
            decoration: InputDecoration(
              labelText: "Retype password",
              prefixIcon: Icon(Icons.lock),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                    hideRetypePass ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      hideRetypePass = !hideRetypePass;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
