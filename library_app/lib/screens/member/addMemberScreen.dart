import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/blocs/members_bloc/members_bloc.dart';
import 'package:library_app/streams/addMember_stream.dart';

class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  bool typeAdmin = false;
  bool hidePass = true;
  TextEditingController _name;
  TextEditingController _email;
  TextEditingController _phone;
  TextEditingController _username;
  TextEditingController _password;

  GlobalKey addMemberKey = GlobalKey();
  AddMemberStream addMemberStream;
  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    addMemberStream = AddMemberStream();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _username.dispose();
    _password.dispose();
    addMemberStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => MembersBloc(),
      child: BlocListener<MembersBloc, MembersState>(
        listener: (context, state) {
          if (state is LoadingState) {
            SpinKitDoubleBounce(color: Colors.white);
          } else if (state is SuccessState) {
            _showDialog(context, state.title, state.message);
          } else if (state is ShowPasswordOldState) {
            hidePass = state.showPass;
          } else if (state is CheckAdminState) {
            typeAdmin = state.admin;
          } else if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          }
        },
        child: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            return Scaffold(
              key: addMemberKey,
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
                "Add Member",
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<MembersBloc>(addMemberKey.currentContext).add(
                  PressButtonAddEvent(
                      username: _username.text.trim(),
                      password: _password.text.trim(),
                      name: _name.text.trim(),
                      email: _email.text.trim(),
                      phone: _phone.text.trim(),
                      admin: typeAdmin,
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
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.1),
          StreamBuilder(
            stream: addMemberStream.nameStream,
            builder: (context, snapshot) => TextField(
              controller: _name,
              onChanged: (a) {
                addMemberStream.nameChange(a.trim());
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Full name",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.assignment),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          StreamBuilder(
            stream: addMemberStream.phoneStream,
            builder: (context, snapshot) => TextField(
              controller: _phone,
              onChanged: (a) {
                addMemberStream.phoneChange(a.trim());
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.phone),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          StreamBuilder(
            stream: addMemberStream.userStream,
            builder: (context, snapshot) => TextField(
              controller: _username,
              onChanged: (a) {
                addMemberStream.userChange(a.trim());
              },
              keyboardType: TextInputType.phone,
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
          SizedBox(height: screenHeight * 0.02),
          StreamBuilder(
            stream: addMemberStream.passStream,
            builder: (context, snapshot) => TextField(
              controller: _password,
              onChanged: (a) {
                addMemberStream.passChange(a.trim());
              },
              keyboardType: TextInputType.text,
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
                    BlocProvider.of<MembersBloc>(addMemberKey.currentContext)
                        .add(
                      ShowPasswordOldEvent(showPass: hidePass),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          InkWell(
            onTap: () {
              BlocProvider.of<MembersBloc>(addMemberKey.currentContext)
                  .add(CheckAdminEvent(admin: typeAdmin));
            },
            child: Container(
              height: screenHeight * 0.05,
              child: Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Admin",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple[400],
                    ),
                  ),
                  Container(
                    width: screenHeight * 0.04,
                    height: screenHeight * 0.04,
                    child: Icon(
                      typeAdmin
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: Colors.purple[400],
                    ),
                  )
                ],
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
