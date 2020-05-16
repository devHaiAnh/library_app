import 'package:flutter/material.dart';
import 'package:library_app/model/bookHome.dart';
import 'package:library_app/model/categoryHome.dart';
import 'package:library_app/screens/bookListHome.dart';
import 'package:library_app/screens/bookScreen.dart';
import 'package:library_app/screens/home/categoryBookHome.dart';
import 'package:library_app/screens/home/categoryListHome.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:library_app/screens/widget/itemBookHome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => TestPage()));
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
              itemCount: bookList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookPage(
                                  book: bookList[index],
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    margin: EdgeInsets.all(screenWidth * 0.02),
                    width: screenWidth * 0.7,
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
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(bookList[index].image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.only(left: screenWidth * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  bookList[index].name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  bookList[index].author,
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Container(
                                  height: screenHeight * 0.008,
                                  width: screenWidth * 0.3,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookListHomePage(title: "New")));
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
                    itemCount: bookList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookPage(
                                          book: bookList[index],
                                        )));
                          },
                          child: ItemBookHome(
                            width: screenWidth,
                            height: screenHeight,
                            itemBook: bookList[index],
                          ));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookListHomePage(title: "Trending")));
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
                    itemCount: bookList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookPage(
                                          book: bookList[index],
                                        )));
                          },
                          child: ItemBookHome(
                            width: screenWidth,
                            height: screenHeight,
                            itemBook: bookList[index],
                          ));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryListHomePage()));
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
              itemCount: categoryList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryBookHomePage()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: screenHeight * 0.15,
                    width: screenWidth * 0.25,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          categoryList[index].image,
                          width: screenWidth * 0.07,
                          height: screenHeight * 0.05,
                          color: Colors.purple,
                        ),
                        Text(
                          categoryList[index].name,
                          style: TextStyle(color: Colors.purple, fontSize: 15),
                        ),
                        Text(
                          "${categoryList[index].count} books",
                          style: TextStyle(color: Colors.purple, fontSize: 10),
                        )
                      ],
                    ),
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
      height: screenHeight * 0.21,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "hi Ảnh Hai",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
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
}
