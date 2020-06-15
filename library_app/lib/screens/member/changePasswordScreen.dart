import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/blocs/member_bloc/member_bloc.dart';
import 'package:library_app/streams/changePass_stream.dart';

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

  GlobalKey changePassKey = GlobalKey();
  ChangePassStream changePassStream;
  @override
  void initState() {
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
    _retypePassword = TextEditingController();
    changePassStream = ChangePassStream();
    super.initState();
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _retypePassword.dispose();
    changePassStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => MemberBloc(),
      child: BlocListener<MemberBloc, MemberState>(
        listener: (context, state) {
          if (state is LoadingState) {
            SpinKitDoubleBounce(color: Colors.white);
          } else if (state is SuccessState) {
            _showDialog(context, state.title, state.message);
          } else if (state is ShowPasswordOldState) {
            hideOldPass = state.showPass;
          } else if (state is ShowPasswordNewState) {
            hideNewPass = state.showPass;
          } else if (state is ShowPasswordRetypeState) {
            hideRetypePass = state.showPass;
          } else if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          }
        },
        child: BlocBuilder<MemberBloc, MemberState>(
          builder: (context, state) {
            return Scaffold(
              key: changePassKey,
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
          },
        ),
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
              BlocProvider.of<MemberBloc>(changePassKey.currentContext).add(
                  ChangePasswordEvent(
                      passOld: _oldPassword.text.trim(),
                      passNew: _newPassword.text.trim(),
                      passRetype: _retypePassword.text.trim(),
                      context: context));
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
    final image =
        "https://cdn.pixabay.com/photo/2017/08/26/20/19/library-2684238_960_720.jpg";
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
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.red,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: data(screenWidth, screenHeight),
          ),
        ],
      ),
    );
  }

  Widget data(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.1),
          StreamBuilder(
            stream: changePassStream.passOldStream,
            builder: (context, snapshot) => TextField(
              controller: _oldPassword,
              onChanged: (a) {
                changePassStream.passOldChange(a.trim());
              },
              keyboardType: TextInputType.text,
              obscureText: hideOldPass,
              decoration: InputDecoration(
                labelText: "Old password",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.lock_outline),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      hideOldPass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    BlocProvider.of<MemberBloc>(changePassKey.currentContext)
                        .add(ShowPasswordOldEvent(showPass: hideOldPass));
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          StreamBuilder(
            stream: changePassStream.passNewStream,
            builder: (context, snapshot) => TextField(
              controller: _newPassword,
              onChanged: (a) {
                changePassStream.passNewChange(a.trim());
              },
              keyboardType: TextInputType.text,
              obscureText: hideNewPass,
              decoration: InputDecoration(
                labelText: "New password",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.lock),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      hideNewPass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    BlocProvider.of<MemberBloc>(changePassKey.currentContext)
                        .add(ShowPasswordNewEvent(showPass: hideNewPass));
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          StreamBuilder(
            stream: changePassStream.passRetypeStream,
            builder: (context, snapshot) => TextField(
              controller: _retypePassword,
              onChanged: (a) {
                changePassStream.passRetypeChange(
                    _newPassword.text.trim(), a.trim());
              },
              keyboardType: TextInputType.text,
              obscureText: hideRetypePass,
              decoration: InputDecoration(
                labelText: "Retype password",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.lock),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      hideRetypePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    BlocProvider.of<MemberBloc>(changePassKey.currentContext)
                        .add(ShowPasswordRetypeEvent(showPass: hideRetypePass));
                  },
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
