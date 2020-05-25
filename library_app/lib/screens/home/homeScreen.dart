import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/home_bloc/home_bloc.dart';
import 'package:library_app/data/model/category.dart';
import 'package:library_app/data/model/login_model.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:library_app/screens/widget/itemCategoryHome.dart';
import 'package:library_app/screens/widget/itemMember.dart';

class HomePage extends StatefulWidget {
  final Member model;
  HomePage({Key key, @required this.model}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _oldPassword;
  TextEditingController _newPassword;
  TextEditingController _retypePassword;

  bool hidePass = true;
  bool hideOldPass = true;
  bool hideNewPass = true;
  bool hideRetypePass = true;

  GlobalKey homeKey = GlobalKey();

  @override
  void initState() {
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
    _retypePassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _retypePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              key: homeKey,
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
                      child: AppBarApp(
                        buttonBack: 0,
                        width: screenWidth,
                        height: screenHeight,
                        title: "Home",
                      )),
                  // contain page
                  Positioned(
                    top: screenHeight * 0.12,
                    bottom: screenHeight * 0.005,
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
      height: screenHeight * 0.88,
      width: screenWidth,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // search
            search(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.02),
            // category book
            category(screenHeight, screenWidth, context),
            SizedBox(height: screenHeight * 0.01),
            // trending
            trending(screenHeight, screenWidth, context),
            SizedBox(height: screenHeight * 0.02),
            // new book
            newBook(screenHeight, screenWidth, context),
            SizedBox(height: screenHeight * 0.02),
            // my book
            myBook(screenHeight, screenWidth),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget myBook(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.37,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "My Book",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeKey.currentContext)
                        .add(PressBtnMoveMyBookAllEvent(context: context));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.3,
            margin: EdgeInsets.only(left: screenWidth * 0.03),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeKey.currentContext)
                        .add(PressBtnMoveMyBookEvent(context: context));
                  },
                  // child: ItemBookHistory(
                  //   width: screenWidth,
                  //   height: screenHeight,
                  //   itemBook: bookList[index],
                  // ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget newBook(
      double screenHeight, double screenWidth, BuildContext context) {
    return Container(
      height: screenHeight * 0.37,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "New Book",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeKey.currentContext)
                        .add(PressBtnMoveNewBookAllEvent(context: context));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.31,
            width: screenWidth,
            padding: EdgeInsets.all(screenWidth * 0.02),
            margin: EdgeInsets.only(left: screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: screenHeight * 0.285,
                  width: screenWidth * 0.92,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<HomeBloc>(homeKey.currentContext)
                              .add(PressBtnMoveNewBookEvent(context: context));
                        },
                        // child: ItemBookHome(
                        //   width: screenWidth,
                        //   height: screenHeight,
                        //   itemBook: bookList[index],
                        // ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget trending(
      double screenHeight, double screenWidth, BuildContext context) {
    return Container(
      height: screenHeight * 0.37,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Trending",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeKey.currentContext)
                        .add(PressBtnMoveTrendingAllEvent(context: context));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.31,
            width: screenWidth,
            padding: EdgeInsets.all(screenWidth * 0.02),
            margin: EdgeInsets.only(left: screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: screenHeight * 0.285,
                  width: screenWidth * 0.92,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<HomeBloc>(homeKey.currentContext)
                              .add(PressBtnMoveTrendingEvent(context: context));
                        },
                        // child: ItemBookHome(
                        //   width: screenWidth,
                        //   height: screenHeight,
                        //   itemBook: bookList[index],
                        // ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget category(
      double screenHeight, double screenWidth, BuildContext context) {
    return Container(
      height: screenHeight * 0.26,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeKey.currentContext)
                        .add(PressBtnMoveCategoryAllEvent(context: context));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.2,
            width: screenWidth,
            margin: EdgeInsets.only(left: screenWidth * 0.05),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeKey.currentContext)
                        .add(PressBtnMoveCategoryEvent(context: context));
                  },
                  child: ItemCategoryHome(
                    width: screenWidth,
                    height: screenHeight,
                    itemCategoryBook: categoryList[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget search(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.22,
      child: Column(
        children: <Widget>[
          Container(
            height: screenHeight * 0.05,
            margin: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Hi ${widget.model.username}",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogUser(screenHeight, screenWidth, context);
                      },
                    );
                  },
                  child: Container(
                    height: screenWidth * 0.08,
                    width: screenWidth * 0.08,
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
                      Icons.person,
                      size: 20,
                      color: Colors.purple[400],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.15,
            width: screenWidth,
            padding: EdgeInsets.all(screenWidth * 0.02),
            margin: EdgeInsets.only(left: screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Search your book",
                  style: TextStyle(fontSize: 15, color: Colors.purple),
                ),
                Container(
                  height: screenHeight * 0.07,
                  width: screenWidth,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: screenHeight * 0.01),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 23,
                      ),
                      hintText: "Search here",
                      hintStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[800]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogUser(
      double screenHeight, double screenWidth, BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ), //this right here
      child: Container(
        height: screenHeight * 0.5,
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // close
                  InkWell(
                    onTap: () {
                      BlocProvider.of<HomeBloc>(homeKey.currentContext)
                          .add(PressBtnBackEvent(context: context));
                    },
                    child: Icon(Icons.close),
                  ),
                  // logOut
                  logoutButton(context, screenHeight, screenWidth),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // contain
                  Expanded(
                    flex: 9,
                    // child: Container(),
                    child: ItemMember(
                        width: screenWidth,
                        height: screenHeight,
                        itemMember: widget.model),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // button
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<HomeBloc>(
                                        homeKey.currentContext)
                                    .add(PressBtnMoveEditEvent(
                                        member: widget.model,
                                        context: context));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange[300],
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
                                    "Edit Info",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          // button sure
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<HomeBloc>(
                                        homeKey.currentContext)
                                    .add(PressBtnMoveChangePassEvent(
                                        context: context));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.teal[400],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 6,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(24)),
                                child: Center(
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget logoutButton(
      BuildContext context, double screenHeight, double screenWidth) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ), //this right here
              child: Container(
                height: screenHeight * 0.3,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.03),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(homeKey.currentContext)
                                .add(PressBtnBackEvent(context: context));
                          },
                          child: Icon(Icons.close),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: screenHeight * 0.05,
                                    width: screenWidth,
                                    child: Text(
                                      "Are you log out?",
                                      style: TextStyle(fontSize: 20),
                                    )),
                              ],
                            ),
                          ),
                          // button
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<HomeBloc>(
                                              homeKey.currentContext)
                                          .add(PressBtnBackEvent(
                                              context: context));
                                    },
                                    child: Container(
                                      height: screenHeight * 0.065,
                                      margin: EdgeInsets.only(
                                          right: screenWidth * 0.01),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // button sure
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<HomeBloc>(
                                              homeKey.currentContext)
                                          .add(PressBtnLogoutEvent(
                                              context: context));
                                    },
                                    child: Container(
                                      height: screenHeight * 0.065,
                                      margin: EdgeInsets.only(
                                          right: screenWidth * 0.01),
                                      decoration: BoxDecoration(
                                          color: Colors.red[400],
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Center(
                                        child: Text(
                                          "Leave",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Icon(
        Icons.power_settings_new,
        color: Colors.red,
      ),
    );
  }
}
