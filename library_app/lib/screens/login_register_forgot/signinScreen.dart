import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/login_bloc/login_bloc.dart';
import 'package:library_app/screens/login_register_forgot/forgotPassword.dart';
import 'package:library_app/screens/login_register_forgot/signupScreen.dart';
import 'package:library_app/screens/totalScreen.dart';
import 'package:library_app/screens/widget/imageLogin.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final background =
      "https://images.pexels.com/photos/207730/pexels-photo-207730.jpeg?auto=compress&cs=tinysrgb&h=650&w=940";
  TextEditingController _username;
  TextEditingController _pass;

  bool savePass = false;
  bool hidePass = true;

  GlobalKey _loginKey = GlobalKey();

  @override
  void setState(fn) {
    _username = TextEditingController(text: "admin@admin.com");
    _pass = TextEditingController(text: "admin");
    super.setState(fn);
  }

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
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoadingState) {
          } else if (state is ShowPasswordState) {
            hidePass = state.showPass;
          } else if (state is SavePasswordState) {
            savePass = state.savePass;
          } else if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return WillPopScope(
              onWillPop: _onWillPop,
              child: Scaffold(
                key: _loginKey,
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
          },
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
                  BlocProvider.of<LoginBloc>(_loginKey.currentContext)
                      .add(ShowPasswordEvent(showPass: hidePass));
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
                    BlocProvider.of(_loginKey.currentContext)
                        .add(SavePasswordEvent(savePass: savePass));
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
                    BlocProvider.of(_loginKey.currentContext)
                        .add(PressButtonMoveForgotEvent(context: context));
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
              BlocProvider.of(_loginKey.currentContext).add(
                  PressButtonLoginEvent(
                      username: _username.text,
                      passowrd: _pass.text,
                      context: context));
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
              BlocProvider.of(_loginKey.currentContext)
                  .add(PressButtonMoveRegisterEvent(context: context));
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

  _showDialog(BuildContext mainContext, String title, String message) async {
    await showDialog(
      context: mainContext,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
