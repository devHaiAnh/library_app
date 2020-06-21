import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/blocs/members_bloc/members_bloc.dart';
import 'package:library_app/data/model/members_model.dart';
import 'package:library_app/streams/updateMember_stream.dart';

class EditMembersPage extends StatefulWidget {
  final Member member;
  EditMembersPage({Key key, this.member}) : super(key: key);

  @override
  _EditMembersPageState createState() => _EditMembersPageState();
}

class _EditMembersPageState extends State<EditMembersPage> {
  bool typeAdmin = false;
  TextEditingController _name;
  TextEditingController _email;
  TextEditingController _address;

  GlobalKey editMemberKey = GlobalKey();
  UpdateMemberStream updateMemberStream;
  @override
  void initState() {
    _name = TextEditingController(text: widget.member.name);
    _email = TextEditingController(text: widget.member.email);
    _address = TextEditingController(text: widget.member.address);
    typeAdmin = widget.member.admin;
    updateMemberStream = UpdateMemberStream();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _address.dispose();
    updateMemberStream.dispose();
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
          } else if (state is CheckAdminState) {
            typeAdmin = state.admin;
          } else if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          }
        },
        child: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            return Scaffold(
              key: editMemberKey,
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
                      child: Container(
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: Text(
                                  "Edit Member",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<MembersBloc>(
                                        editMemberKey.currentContext)
                                    .add(PressButtonUpdateEvent(
                                        username: widget.member.username,
                                        name: _name.text.trim(),
                                        email: _email.text.trim(),
                                        address: _address.text.trim(),
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
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
                      ),
                    ),
                  ),
                  // contain
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: containPage(screenHeight, screenWidth),
                  ),
                  // image book
                  // Positioned(
                  //   top: screenHeight * 0.1,
                  //   left: screenWidth * 0.35,
                  //   right: screenWidth * 0.35,
                  //   child: Container(
                  //     height: screenHeight * 0.25,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       image: DecorationImage(
                  //         image: AssetImage(widget.member.admin
                  //             ? "assets/img/admin.png"
                  //             : "assets/img/member.png"),
                  //         // fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget containPage(double screenHeight, double screenWidth) {
    final image =
        "https://cdn.pixabay.com/photo/2017/08/29/08/32/library-2692432_960_720.jpg";
    return SingleChildScrollView(
      child: Container(
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
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: image,
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
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // username
                    SizedBox(height: screenHeight * 0.04),
                    username(screenWidth),
                    SizedBox(height: screenHeight * 0.01),
                    Divider(thickness: 1),
                    SizedBox(height: screenHeight * 0.01),
                    data(screenWidth, screenHeight)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget data(double screenWidth, double screenHeight) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
            stream: updateMemberStream.nameStream,
            builder: (context, snapshot) => TextField(
              controller: _name,
              onChanged: (a) {
                updateMemberStream.nameChange(a.trim());
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Full name",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.person),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          StreamBuilder(
            stream: updateMemberStream.emailStream,
            builder: (context, snapshot) => TextField(
              controller: _email,
              onChanged: (a) {
                updateMemberStream.emailChange(a.trim());
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
          SizedBox(height: screenHeight * 0.01),
          StreamBuilder(
            stream: updateMemberStream.addressStream,
            builder: (context, snapshot) => TextField(
              controller: _address,
              onChanged: (a) {
                updateMemberStream.addressChange(a.trim());
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Address",
                errorText: snapshot.hasError ? snapshot.error : null,
                prefixIcon: Icon(Icons.home),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          InkWell(
            onTap: () {
              BlocProvider.of<MembersBloc>(editMemberKey.currentContext)
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

  Widget username(double screenWidth) {
    return Container(
      width: screenWidth,
      child: Center(
        child: Text(
          widget.member.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.purple[400],
          ),
        ),
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
