import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final background =
      "https://images.pexels.com/photos/3747522/pexels-photo-3747522.jpeg?auto=compress&cs=tinysrgb&h=650&w=940";
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _pass = TextEditingController();
  final _pass2 = TextEditingController();

  bool hidePass = true;
  bool hidePassRetype = true;

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _pass.dispose();
    _pass2.dispose();
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
            child: Container(
              height: screenHeight * 0.5,
              child: Image.network(
                background,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // appbar
          Positioned(
            top: 0,
            left: screenWidth * 0.1,
            child: SafeArea(
              top: true,
              left: true,
              right: true,
              child: InkWell(
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
            ),
          ),
          // button
          Positioned(
            bottom: 0,
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
      height: screenHeight * 0.7,
      padding: EdgeInsets.all(screenWidth * 0.08),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: screenHeight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container()
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          TextField(
            controller: _email,
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          TextField(
            controller: _username,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Username",
              prefixIcon: Icon(Icons.person),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          TextField(
            controller: _pass,
            obscureText: hidePass,
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.vpn_key),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              suffixIcon: IconButton(
                icon: Icon(hidePass ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      hidePass = !hidePass;
                    },
                  );
                },
              ),
            ),
          ),
          TextField(
            controller: _pass2,
            obscureText: hidePassRetype,
            decoration: InputDecoration(
              labelText: "Retype Password",
              prefixIcon: Icon(Icons.vpn_key),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                    hidePassRetype ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      hidePassRetype = !hidePassRetype;
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => SignInPage()));
            },
            child: Container(
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(24)),
              child: Center(
                child: Text(
                  "Change Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
