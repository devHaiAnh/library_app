import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/blocs/login_bloc/login_bloc.dart';
import 'package:library_app/screens/widget/imageLogin.dart';
import 'package:library_app/streams/login_stream.dart';

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

  GlobalKey loginKey = GlobalKey();
  LoginStream loginStream;

  @override
  void setState(fn) {
    _username = TextEditingController();
    _pass = TextEditingController();
    loginStream = LoginStream();
    super.setState(fn);
  }

  @override
  void dispose() {
    _username.dispose();
    _pass.dispose();
    loginStream.dispose();
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
            SpinKitDoubleBounce(color: Colors.white);
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
                key: loginKey,
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
          StreamBuilder(
            stream: loginStream.userStream,
            builder: (context, snapshot) => TextField(
              controller: _username,
              onChanged: (a) {
                loginStream.userChange(a.trim());
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Username",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.person),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: loginStream.passStream,
            builder: (context, snapshot) => TextField(
              controller: _pass,
              onChanged: (a) {
                loginStream.passChange(a.trim());
              },
              obscureText: hidePass,
              decoration: InputDecoration(
                labelText: "Password",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.lock),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                suffixIcon: IconButton(
                  icon:
                      Icon(hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(loginKey.currentContext)
                        .add(ShowPasswordEvent(showPass: hidePass));
                  },
                ),
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
                    BlocProvider.of(loginKey.currentContext)
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
                    BlocProvider.of(loginKey.currentContext)
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
              BlocProvider.of(loginKey.currentContext).add(
                  PressButtonLoginEvent(
                      username: _username.text.trim(),
                      passowrd: _pass.text.trim(),
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
              BlocProvider.of(loginKey.currentContext)
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
