import 'package:flutter/material.dart';
import 'package:library_app/data/model/categoryHome.dart';
import 'package:library_app/screens/home/categoryBookHome.dart';
import 'package:library_app/screens/widget/appbarApp.dart';

class CategoryListHomePage extends StatefulWidget {
  @override
  _CategoryListHomePageState createState() => _CategoryListHomePageState();
}

class _CategoryListHomePageState extends State<CategoryListHomePage> {
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
                buttonBack: 1,
                width: screenWidth,
                height: screenHeight,
                title: "All Categories",
              )),
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
          )),
      child: GridView.builder(
        itemCount: categoryList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryBookHomePage()));
            },
            child: itemCategory(screenHeight, screenWidth, index),
          );
        },
      ),
    );
  }

  Widget itemCategory(double screenHeight, double screenWidth, int index) {
    return Container(
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
    );
  }
}
