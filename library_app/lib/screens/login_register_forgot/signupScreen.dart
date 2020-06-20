import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/blocs/register_bloc/register_bloc.dart';
import 'package:library_app/screens/widget/imageLogin.dart';
import 'package:library_app/streams/register_stream.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final background =
      "https://images.pexels.com/photos/1837726/pexels-photo-1837726.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

  TextEditingController _email;
  TextEditingController _username;
  TextEditingController _pass;

  bool hidePass = true;

  GlobalKey _registerKey = GlobalKey();
  RegisterStream _registerStream;

  @override
  void initState() {
    _email = TextEditingController();
    _username = TextEditingController();
    _pass = TextEditingController();
    _registerStream = RegisterStream();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _pass.dispose();
    _registerStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is LoadingState) {
            SpinKitDoubleBounce(color: Colors.white);
          } else if (state is SuccessState) {
            _showDialog(context, state.title, state.message);
          } else if (state is ShowPasswordState) {
            hidePass = state.showPass;
          } else if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Scaffold(
              key: _registerKey,
              body: Stack(
                children: <Widget>[
                  // background
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: screenHeight * 0.5,
                      child: CachedNetworkImage(
                        imageUrl: background,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
          },
        ),
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
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Container(
                //       width: screenWidth * 0.1,
                //       height: screenWidth * 0.1,
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.red[400]),
                //           borderRadius: BorderRadius.circular(24)),
                //       child: Icon(
                //         Icons.camera_alt,
                //         color: Colors.red[400],
                //       ),
                //     ),
                //     Text(
                //       "Upload image",
                //       style: TextStyle(color: Colors.grey[600], fontSize: 13),
                //     )
                //   ],
                // )
                Container()
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          StreamBuilder(
            stream: _registerStream.emailStream,
            builder: (context, snapshot) => TextField(
              controller: _email,
              onChanged: (a) {
                _registerStream.emailChange(a.trim());
              },
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
            stream: _registerStream.userStream,
            builder: (context, snapshot) => TextField(
              controller: _username,
              onChanged: (a) {
                _registerStream.userChange(a.trim());
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
            stream: _registerStream.passStream,
            builder: (context, snapshot) => TextField(
              controller: _pass,
              onChanged: (a) {
                _registerStream.passChange(a.trim());
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
                    BlocProvider.of<RegisterBloc>(_registerKey.currentContext)
                        .add(ShowPasswordEvent(showPass: hidePass));
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          InkWell(
            onTap: () {
              BlocProvider.of<RegisterBloc>(_registerKey.currentContext).add(
                  PressButtonRegisterEvent(
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
              BlocProvider.of<RegisterBloc>(_registerKey.currentContext)
                  .add(PressButtonMoveLoginEvent(context: context));
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
