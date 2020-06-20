import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/books_bloc/books_bloc.dart';
import 'package:library_app/data/model/books_model.dart';

class BookPage extends StatefulWidget {
  BookPage({Key key, @required this.book, this.function}) : super(key: key);
  final Book book;
  final Function function;

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with TickerProviderStateMixin {
  TabController _controller;
  int count = 1;

  GlobalKey bookKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    // count = 1;
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
    return BlocProvider(
      create: (context) => BooksBloc(),
      child: BlocListener<BooksBloc, BooksState>(
        listener: (context, state) {
          if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          } else if (state is PressBookmarkState) {
            widget.book.bookmark = state.bookmark;
          }
        },
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            return Scaffold(
              key: bookKey,
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
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  BlocProvider.of<BooksBloc>(
                                          bookKey.currentContext)
                                      .add(PressButtonBackEvent(
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
                                    Icons.arrow_back_ios,
                                    size: 18,
                                  ),
                                )),
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
                    child: containPage(screenHeight, screenWidth, context),
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
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
          // bookmark
          bookMark(),
          // contain
          contain(screenWidth, screenHeight, context),
        ],
      ),
    );
  }

  Widget contain(
      double screenWidth, double screenHeight, BuildContext context) {
    return Expanded(
      flex: 9,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // info book
            infoBook(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.01),
            Divider(thickness: 1),
            SizedBox(height: screenHeight * 0.01),
            // tabbar
            tabbar(screenHeight),
            SizedBox(height: screenHeight * 0.02),
            // tabbar view
            tabbarView(screenHeight, screenWidth),
            SizedBox(height: screenHeight * 0.01),
            // bottom button
            button(screenWidth, screenHeight, context)
          ],
        ),
      ),
    );
  }

  Widget button(double screenWidth, double screenHeight, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: screenWidth * 0.025),
      height: screenHeight * 0.14,
      width: screenWidth * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              readDirectlyButton(context, screenHeight, screenWidth),
              readRentalButton(context, screenHeight, screenWidth),
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
          addCartButton(context, screenHeight, screenWidth),
        ],
      ),
    );
  }

  Widget addCartButton(
      BuildContext context, double screenHeight, double screenWidth) {
    return InkWell(
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
                child: DialogCart(book: widget.book));
          },
        );
      },
      child: Container(
        height: screenHeight * 0.065,
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
            color: Colors.purple[400],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(
            "Add Your Cart",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget readRentalButton(
      BuildContext context, double screenHeight, double screenWidth) {
    return InkWell(
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
                            BlocProvider.of<BooksBloc>(bookKey.currentContext)
                                .add(PressButtonBackEvent(context: context));
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
                                      "Are you sure?",
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
                                      BlocProvider.of<BooksBloc>(
                                              bookKey.currentContext)
                                          .add(PressButtonBackEvent(
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
                                      BlocProvider.of<BooksBloc>(
                                              bookKey.currentContext)
                                          .add(
                                        PressButtonAddPaymentEvent(
                                          book: widget.book,
                                          status: 2,
                                          context: context,
                                        ),
                                      );
                                      BlocProvider.of<BooksBloc>(
                                              bookKey.currentContext)
                                          .add(PressButtonBackEvent(
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
                                          "Sure",
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
      child: Container(
        height: screenHeight * 0.065,
        width: screenWidth * 0.42,
        decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Book Rental",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "\$ 2/week",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget readDirectlyButton(
      BuildContext context, double screenHeight, double screenWidth) {
    return InkWell(
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
                            BlocProvider.of<BooksBloc>(bookKey.currentContext)
                                .add(PressButtonBackEvent(context: context));
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
                                      "Are you sure?",
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
                                      BlocProvider.of<BooksBloc>(
                                              bookKey.currentContext)
                                          .add(PressButtonBackEvent(
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
                                      BlocProvider.of<BooksBloc>(
                                              bookKey.currentContext)
                                          .add(
                                        PressButtonAddPaymentEvent(
                                          book: widget.book,
                                          status: 1,
                                          context: context,
                                        ),
                                      );
                                      BlocProvider.of<BooksBloc>(
                                              bookKey.currentContext)
                                          .add(PressButtonBackEvent(
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
                                          "Sure",
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
      child: Container(
        height: screenHeight * 0.065,
        width: screenWidth * 0.42,
        decoration: BoxDecoration(
            color: Colors.green,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Read Directly",
              style: TextStyle(fontSize: 15, color: Colors.white),
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
    );
  }

  Widget tabbarView(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.22,
      width: screenWidth * 0.85,
      margin: EdgeInsets.only(left: screenWidth * 0.025),
      child: TabBarView(
        controller: _controller,
        children: [
          aboutBook(screenWidth, screenHeight),
          authorInfo(screenWidth, screenHeight, widget.book.imageAuthor),
        ],
      ),
    );
  }

  Widget tabbar(double screenHeight) {
    return Container(
      height: screenHeight * 0.05,
      child: TabBar(
        controller: _controller,
        labelColor: Colors.purple[900],
        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        unselectedLabelColor: Colors.grey[400],
        indicatorColor: Colors.purple,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(text: "About Book"),
          Tab(text: "Author's Info"),
        ],
      ),
    );
  }

  Widget infoBook(double screenWidth, double screenHeight) {
    return Container(
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
                    fontSize: 9),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          // author
          Text(
            widget.book.author,
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          SizedBox(height: screenHeight * 0.003),
          // name
          Text(
            widget.book.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      ),
    );
  }

  Widget bookMark() {
    return Expanded(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                widget.book.bookmark = !widget.book.bookmark;
                widget.function(widget.book.bookmark);
                BlocProvider.of<BooksBloc>(bookKey.currentContext).add(
                    PressBookmarkEvent(book: widget.book, context: context));
              });
            },
            child: Container(
              child: Icon(Icons.bookmark,
                  color: widget.book.bookmark ? Colors.amber : Colors.grey),
            ),
          ),
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
                    widget.book.evaluateBook.toString(),
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
        SizedBox(height: screenHeight * 0.01),
        // description
        Container(
          height: screenHeight * 0.125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Description",
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: screenHeight * 0.005),
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
                  image: NetworkImage(image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
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
                Row(
                  children: <Widget>[
                    Text(
                      widget.book.evaluateAuthor.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                        height: screenHeight * 0.015,
                        child: Icon(Icons.star,
                            size: 12, color: Colors.amberAccent))
                  ],
                ),
                // Text(
                //   widget.book.evaluate.toString(),
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ),
        ),
      ],
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

class DialogCart extends StatefulWidget {
  final Book book;
  DialogCart({@required this.book});
  @override
  _DialogCartState createState() => _DialogCartState();
}

class _DialogCartState extends State<DialogCart> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => BooksBloc(),
      child: BlocListener<BooksBloc, BooksState>(
        listener: (context, state) {},
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            return Container(
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
                          BlocProvider.of<BooksBloc>(context)
                              .add(PressButtonBackEvent(context: context));
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              countCart(screenHeight, screenWidth),
                              Text(
                                "\$ ${(widget.book.cost * count).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        // button
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              // button sure
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<BooksBloc>(context).add(
                                        PressButtonAddCartEvent(
                                            book: widget.book,
                                            count: count,
                                            cost: widget.book.cost * count,
                                            context: context));
                                    BlocProvider.of<BooksBloc>(context).add(
                                        PressButtonBackEvent(context: context));
                                  },
                                  child: Container(
                                    height: screenHeight * 0.065,
                                    margin: EdgeInsets.only(
                                        right: screenWidth * 0.01),
                                    decoration: BoxDecoration(
                                        color: Colors.red[400],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                        "Confirm",
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
            );
          },
        ),
      ),
    );
  }

  Widget countCart(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.25,
      child: Container(
        width: screenWidth * 0.25,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.purple),
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (count > 1) {
                      count--;
                    }
                  });
                },
                child: Container(
                  child: Icon(Icons.navigate_before, color: Colors.purple[300]),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: Text(
                    count.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.purple[300]),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (count < 99) {
                      count++;
                    }
                  });
                },
                child: Container(
                  child: Icon(Icons.navigate_next, color: Colors.purple[300]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
