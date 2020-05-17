import 'package:flutter/material.dart';
import 'package:library_app/screens/forgotPassword.dart';
import 'package:library_app/screens/signupScreen.dart';
import 'package:library_app/screens/totalScreen.dart';
import 'package:library_app/screens/widget/imageLogin.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final background =
      "https://images.pexels.com/photos/207730/pexels-photo-207730.jpeg?auto=compress&cs=tinysrgb&h=650&w=940";
  final _username = TextEditingController(text: "admin@admin.com");
  final _pass = TextEditingController(text: "admin");

  bool savePass = false;
  bool hidePass = true;

  @override
  void dispose() {
    _username.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                top: screenHeight * 0.1,
                left: screenWidth * 0.08,
                child: ImageLogin(
                  width: screenWidth,
                  height: screenHeight,
                )),
            // contain
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: containPage(screenHeight, screenWidth, context),
            )
          ],
        ),
      ),
    );
  }

  Widget containPage(
      double screenHeight, double screenWidth, BuildContext context) {
    return Container(
      height: screenHeight * 0.6,
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
          Text(
            "Welcome back",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenHeight * 0.005),
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
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      savePass = !savePass;
                    });
                  },
                  child: Container(
                      height: screenHeight * 0.05,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Save Password?",
                            style: TextStyle(color: Colors.purple),
                          ),
                          Container(
                            width: screenHeight * 0.04,
                            height: screenHeight * 0.04,
                            child: Icon(
                              savePass
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: Colors.purple,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()));
                  },
                  child: Container(
                    height: screenHeight * 0.05,
                    child: Center(
                        child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.purple),
                    )),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.04),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TotalPage()));
            },
            child: Container(
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(24)),
              child: Center(
                child: Text(
                  "Sign in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Container(
              height: screenHeight * 0.05,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "You are a new member? ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: "Sign up here",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
