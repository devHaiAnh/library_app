import 'package:flutter/material.dart';
import 'package:library_app/model/bookHome.dart';
import 'package:library_app/model/categoryHome.dart';
import 'package:library_app/screens/bookScreen.dart';
import 'package:library_app/screens/widget/appbarApp.dart';

class CategoryBookHomePage extends StatefulWidget {
  // CategoryBookHomePage({Key key, this.index}) : super(key: key);
  // final int index;
  @override
  _CategoryBookHomePageState createState() => _CategoryBookHomePageState();
}

class _CategoryBookHomePageState extends State<CategoryBookHomePage>
    with TickerProviderStateMixin {
  TabController _controller;

  final List<Tab> myTabs = <Tab>[
    Tab(text: categoryList[0].name),
    Tab(text: categoryList[1].name),
    Tab(text: categoryList[2].name),
    Tab(text: categoryList[3].name),
    Tab(text: categoryList[4].name),
    Tab(text: categoryList[5].name),
    Tab(text: categoryList[6].name),
    Tab(text: categoryList[7].name),
    Tab(text: categoryList[8].name),
    Tab(text: categoryList[9].name),
    Tab(text: categoryList[10].name),
    Tab(text: categoryList[11].name),
    Tab(text: categoryList[12].name),
    Tab(text: categoryList[13].name),
    Tab(text: categoryList[14].name),
  ];

  @override
  void initState() {
    _controller = TabController(length: categoryList.length, vsync: this);
    super.initState();
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
                title: "Categories",
              )),
          // tabbar
          Positioned(
            top: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(left: screenWidth * 0.06),
              height: screenHeight * 0.08,
              child: TabBar(
                  controller: _controller,
                  isScrollable: true,
                  labelColor: Colors.purple[900],
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal),
                  indicatorColor: Colors.purple,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: myTabs),
            ),
          ),
          // contain
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
          )),
      child: Column(
        children: <Widget>[
          // search
          search(screenHeight, screenWidth),
          SizedBox(height: screenHeight * 0.02),
          // tabbar view
          tabbarView(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Container tabbarView(double screenWidth, double screenHeight) {
    return Container(
            width: screenWidth,
            height: screenHeight * 0.64,
            child: TabBarView(controller: _controller, children: [
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
              gridViewWG(screenWidth, screenHeight, bookList),
            ]));
  }

  Container search(double screenHeight, double screenWidth) {
    return Container(
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
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey[800]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        );
  }

  Widget gridViewWG(double screenWidth, screenHeight, List<Book> bookList) {
    List<Book> bookHomeList = bookList;
    return GridView.builder(
      itemCount: bookHomeList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // image
                Expanded(
                  flex: 1,
                  child: Container(
                    height: screenHeight * 0.17,
                    margin: EdgeInsets.only(left: screenWidth * 0.03),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            bookHomeList[index].image,
                          ),
                          fit: BoxFit.cover),
                      // borderRadius: BorderRadius.circular(16),
                    ),
                    // child: Placeholder(),
                  ),
                ),
                // contain box
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  bookHomeList[index].bookMark =
                                      !bookHomeList[index].bookMark;
                                  // bookMark = !bookMark;
                                });
                              },
                              child: Container(
                                child: Icon(
                                  Icons.bookmark,
                                  color: bookHomeList[index].bookMark == false
                                      ? Colors.grey
                                      : Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        )),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                bookHomeList[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                bookHomeList[index].author,
                                style: TextStyle(fontSize: 9),
                              ),
                              Container(
                                height: screenHeight * 0.03,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      bookHomeList[index].star.toString(),
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    Container(
                                        height: screenHeight * 0.015,
                                        child: Icon(Icons.star,
                                            size: 10,
                                            color: Colors.amberAccent))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
