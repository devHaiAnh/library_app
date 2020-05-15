import 'package:flutter/material.dart';
import 'package:library_app/model/bookHome.dart';
import 'package:library_app/screens/widget/qrScreen.dart';

class BookPage extends StatefulWidget {
  // HomePage({Key key, this.title}) : super(key: key);

  // final String title;
  BookPage({Key key, this.book}) : super(key: key);
  // final String image;
  final Book book;

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with TickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
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
              height: screenHeight * 0.8,
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
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // info book
                          Container(
                            width: screenWidth,
                            child: Column(
                              children: <Widget>[
                                // category
                                Container(
                                  height: screenHeight * 0.03,
                                  width: screenWidth * 0.13,
                                  color: Colors.green[100],
                                  child: Center(
                                    child: Text(
                                      widget.book.category,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.015),
                                // author
                                Text(
                                  widget.book.author,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                SizedBox(height: screenHeight * 0.003),
                                // name
                                Text(
                                  widget.book.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Divider(thickness: 1),
                          SizedBox(height: screenHeight * 0.01),
                          // info book
                          Container(
                            height: screenHeight * 0.05,
                            child: TabBar(
                              controller: _controller,
                              labelColor: Colors.purple[900],
                              labelStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              unselectedLabelColor: Colors.grey[400],
                              indicatorColor: Colors.purple,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: [
                                Tab(text: "About Book"),
                                Tab(text: "Author's Info"),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // tabbar view
                          Container(
                            height: screenHeight * 0.22,
                            width: screenWidth * 0.85,
                            margin: EdgeInsets.only(left: screenWidth * 0.025),
                            child: TabBarView(
                              controller: _controller,
                              children: [
                                aboutBook(screenWidth, screenHeight),
                                authorInfo(screenWidth, screenHeight,
                                    widget.book.imageAuthor),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          // bottom button
                          Container(
                            margin: EdgeInsets.only(left: screenWidth * 0.025),
                            height: screenHeight * 0.14,
                            width: screenWidth * 0.85,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: screenHeight * 0.065,
                                        width: screenWidth * 0.42,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Read Directly",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "Free",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: screenHeight * 0.065,
                                        width: screenWidth * 0.42,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Book Rental",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "\$ 2/day",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ), //this right here
                                          child: Container(
                                            height: screenHeight * 0.45,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth * 0.05,
                                                vertical: screenHeight * 0.03),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    height: screenHeight * 0.08,
                                                    child: Row(
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Icon(Icons.close),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 9,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                                height:
                                                                    screenHeight *
                                                                        0.05,
                                                                width:
                                                                    screenWidth,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Cost:",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.purple[300]),
                                                                    ),
                                                                    Text(
                                                                      "\$ 177",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .purple,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Container(
                                                                height:
                                                                    screenHeight *
                                                                        0.05,
                                                                width:
                                                                    screenWidth,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Transport Fee:",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.purple[300]),
                                                                    ),
                                                                    Text(
                                                                      "\$ 5",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .purple,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Container(
                                                                height:
                                                                    screenHeight *
                                                                        0.05,
                                                                width:
                                                                    screenWidth,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "VAT (10%): ",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.purple[300]),
                                                                    ),
                                                                    Text(
                                                                      "\$ 18",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .purple,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                            Divider(
                                                                thickness: 1),
                                                            Container(
                                                                height:
                                                                    screenHeight *
                                                                        0.05,
                                                                width:
                                                                    screenWidth,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Total: ",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.purple[300]),
                                                                    ),
                                                                    Text(
                                                                      "\$ 200",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .purple,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      // button
                                                      Expanded(
                                                        flex: 2,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            QRPage()));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                        .purple[
                                                                    400],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16)),
                                                            child: Center(
                                                              child: Text(
                                                                "Confirm",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
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
                                  child: Container(
                                    height: screenHeight * 0.065,
                                    width: screenWidth * 0.9,
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
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "\$ 200",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // image book
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.35,
            right: screenWidth * 0.35,
            child: Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.book.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget aboutBook(double screenWidth, screenHeight) {
    return Column(
      children: <Widget>[
        Container(
          height: screenHeight * 0.08,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Evaluate",
                    style: TextStyle(color: Colors.black45),
                  ),
                  Text(
                    widget.book.star.toString(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Pages",
                    style: TextStyle(color: Colors.black45),
                  ),
                  Text(
                    widget.book.pages.toString(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Cover",
                    style: TextStyle(color: Colors.black45),
                  ),
                  Text(
                    widget.book.cover,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Language",
                    style: TextStyle(color: Colors.black45),
                  ),
                  Text(
                    widget.book.language,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.025),
        // description
        Container(
          height: screenHeight * 0.115,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Description",
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(widget.book.description)
            ],
          ),
        ),
      ],
    );
  }

  Widget authorInfo(double screenWidth, screenHeight, String image) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
            // color: Colors.yellowAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Full Name",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  widget.book.author,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Writing Genre",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  widget.book.writingGenre,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Achievements",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  widget.book.achievements,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Evaluate",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  widget.book.evaluate.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
