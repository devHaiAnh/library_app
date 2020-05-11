import 'package:flutter/material.dart';
import 'package:library_app/screens/forgotPassword.dart';
import 'package:library_app/screens/signupScreen.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final background =
      "https://images.pexels.com/photos/207730/pexels-photo-207730.jpeg?auto=compress&cs=tinysrgb&h=650&w=940";
  final _username = TextEditingController();
  final _pass = TextEditingController();

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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.9,
              child: Container(
                height: screenHeight * 0.5,
                child: Image.network(
                  background,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // appbar
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Container(
              height: screenHeight * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Welcome to \nAhk Library",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/img/logo.png",
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                    ),
                  ),
                  TextField(
                    controller: _pass,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
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
                                    Icons.radio_button_unchecked,
                                    color: Colors.purple,
                                  ),
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordPage()));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Container(
                      height: screenHeight * 0.05,
                      child: Center(
                          child: Text(
                        "Sign up here",
                        style: TextStyle(color: Colors.purple),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}