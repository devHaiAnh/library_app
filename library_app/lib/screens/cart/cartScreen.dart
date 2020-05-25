import 'package:flutter/material.dart';
import 'package:library_app/data/model/book.dart';
import 'package:library_app/screens/book/bookScreen.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:library_app/screens/widget/itemBookCart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                title: "Your Cart",
              )),
          // contain
          Positioned(
            top: screenHeight * 0.12,
            left: 0,
            right: 0,
            bottom: screenHeight * 0.005,
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
          borderRadius: BorderRadius.circular(40)),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 13,
            child: Container(
              child: bookList.length != 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: bookList?.length ?? 0,
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
                          // child: ItemBookCart(
                          //   height: screenHeight,
                          //   width: screenWidth,
                          //   itemBook: bookList[index],
                          // ),
                        );
                      },
                    )
                  : Container(
                      child: Center(
                        child: Text("/* No Data */"),
                      ),
                    ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total:",
                    style: TextStyle(fontSize: 15, color: Colors.purple[300]),
                  ),
                  Text(
                    "\$ 177",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
