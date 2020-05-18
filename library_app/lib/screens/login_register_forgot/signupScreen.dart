import 'package:flutter/material.dart';
import 'package:library_app/screens/login_register_forgot/signinScreen.dart';
import 'package:library_app/screens/widget/imageLogin.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final background =
      "https://images.pexels.com/photos/1837726/pexels-photo-1837726.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _pass = TextEditingController();

  bool hidePass = true;

  @override
  void dispose() {
    _email.dispose();
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
    );
  }

  Widget containPage(
      double screenHeight, double screenWidth, BuildContext context) {
    return Container(
      height: screenHeight * 0.67,
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
                  "New\nMember",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red[400]),
                          borderRadius: BorderRadius.circular(24)),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.red[400],
                      ),
                    ),
                    Text(
                      "Upload image",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
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
                  "Sign up",
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
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
            child: Container(
              height: screenHeight * 0.05,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "You are a member? ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: "Sign in here",
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
}
