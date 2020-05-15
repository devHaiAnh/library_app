import 'package:flutter/material.dart';
import 'package:library_app/model/bookHome.dart';
import 'package:library_app/screens/bookScreen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BookListHomePage extends StatefulWidget {
  BookListHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _BookListHomePageState createState() => _BookListHomePageState();
}

class _BookListHomePageState extends State<BookListHomePage> {
  bool bookMark = false;
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
            child: Container(
              height: screenHeight * 0.5,
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
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      "All ${widget.title} Book",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container()
                  ],
                ),
              ),
            ),
          ),
          // button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
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
                  )),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: bookList.length,
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
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        // contain
                        Container(
                          height: screenHeight * 0.25,
                          padding: EdgeInsets.all(screenWidth * 0.025),
                          margin: EdgeInsets.all(screenWidth * 0.02),
                          width: screenWidth * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: <Widget>[
                              // image
                              Expanded(
                                flex: 3,
                                child: Container(
                                  width: screenWidth,
                                  height: screenHeight,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(bookList[index].image),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              // contain
                              Expanded(
                                flex: 7,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.025),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // name / author + bookmark
                                      Container(
                                        width: screenWidth,
                                        height: screenHeight * 0.06,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    bookList[index].name,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.001),
                                                  Text(
                                                    bookList[index].author,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  bookList[index].bookMark =
                                                      !bookList[index].bookMark;
                                                });
                                              },
                                              child: Container(
                                                  width: screenWidth * 0.09,
                                                  height: screenWidth * 0.09,
                                                  child: Icon(
                                                    Icons.bookmark,
                                                    color: bookList[index]
                                                                .bookMark ==
                                                            true
                                                        ? Colors.amber
                                                        : Colors.black,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      // star ranking
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.005),
                                        height: screenHeight * 0.025,
                                        child: SmoothStarRating(
                                          rating: bookList[index].star,
                                          size: 15,
                                          filledIconData: Icons.star,
                                          halfFilledIconData: Icons.star_half,
                                          defaultIconData: Icons.star_border,
                                          starCount: 5,
                                          allowHalfRating: true,
                                          spacing: 2.0,
                                          color: Colors.yellow[600],
                                          borderColor: Colors.yellow[600],
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      // button
                                      Container(
                                        height: screenHeight * 0.05,
                                        width: screenWidth * 0.6,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              height: screenHeight * 0.05,
                                              width: screenWidth * 0.265,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Read Directly",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Free",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: screenHeight * 0.05,
                                              width: screenWidth * 0.265,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Book Rental",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "\$ 2/day",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      Container(
                                        height: screenHeight * 0.05,
                                        width: screenWidth * 0.6,
                                        // margin: EdgeInsets.only(
                                        //     right: screenWidth * 0.01),
                                        decoration: BoxDecoration(
                                            color: Colors.purple[400],
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Buy Book",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "\$ 200",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // star
                        widget.title == "Trending"
                            ? Positioned(
                                top: screenHeight * 0.015,
                                left: screenWidth * 0.02,
                                child: Container(
                                  width: screenWidth * 0.075,
                                  height: screenWidth * 0.075,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/star.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${index + 1}",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
