import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/blocs/forgot_pass_bloc/forgot_pass_bloc.dart';
import 'package:library_app/streams/forgotPass_stream.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final background =
      "https://images.pexels.com/photos/3747522/pexels-photo-3747522.jpeg?auto=compress&cs=tinysrgb&h=650&w=940";

  TextEditingController _email;
  TextEditingController _username;
  TextEditingController _pass;
  TextEditingController _passRetype;

  bool hidePass = true;
  bool hidePassRetype = true;

  GlobalKey _forgotKey = GlobalKey();
  ForgotPassStream _forgotPassStream;

  @override
  void setState(fn) {
    _email = TextEditingController();
    _username = TextEditingController();
    _pass = TextEditingController();
    _passRetype = TextEditingController();
    _forgotPassStream = ForgotPassStream();
    super.setState(fn);
  }

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _pass.dispose();
    _passRetype.dispose();
    _forgotPassStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ForgotPassBloc(),
      child: BlocListener<ForgotPassBloc, ForgotPassState>(
        listener: (context, state) {
          if (state is LoadingState) {
            SpinKitDoubleBounce(color: Colors.white);
          } else if (state is ShowPasswordState) {
            hidePass = state.showPass;
          } else if (state is ShowPasswordRetypeState) {
            hidePassRetype = state.showPass;
          } else if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          }
        },
        child: BlocBuilder<ForgotPassBloc, ForgotPassState>(
          builder: (context, state) {
            return Scaffold(
              key: _forgotKey,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
          },
        ),
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
          StreamBuilder(
            stream: _forgotPassStream.emailStream,
            builder: (context, snapshot) => TextField(
              controller: _email,
              onChanged: (a) {
                _forgotPassStream.emailChange(a.trim());
              },
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.email),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: _forgotPassStream.userStream,
            builder: (context, snapshot) => TextField(
              controller: _username,
              onChanged: (a) {
                _forgotPassStream.userChange(a.trim());
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
            stream: _forgotPassStream.passStream,
            builder: (context, snapshot) => TextField(
              controller: _pass,
              onChanged: (a) {
                _forgotPassStream.passChange(a.trim());
              },
              obscureText: hidePass,
              decoration: InputDecoration(
                labelText: "Password",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.vpn_key),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                suffixIcon: IconButton(
                  icon:
                      Icon(hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    BlocProvider.of(_forgotKey.currentContext)
                        .add(ShowPasswordState(showPass: hidePass));
                  },
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: _forgotPassStream.passRetypeStream,
            builder: (context, snapshot) => TextField(
              controller: _passRetype,
              onChanged: (a) {
                _forgotPassStream.passRetypeChange(_pass.text.trim(),a.trim());
              },
              obscureText: hidePassRetype,
              decoration: InputDecoration(
                labelText: "Password Retype",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.vpn_key),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      hidePassRetype ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    BlocProvider.of(_forgotKey.currentContext)
                        .add(ShowPasswordRetypeState(showPass: hidePassRetype));
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          InkWell(
            onTap: () {
              BlocProvider.of(_forgotKey.currentContext).add(
                  PressButtonForgotPassEvent(
                      username: _username.text.trim(),
                      passowrd: _pass.text.trim(),
                      email: _email.text.trim(),
                      context: context));
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
