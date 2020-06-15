import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/books_bloc/books_bloc.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:library_app/screens/widget/itemBook.dart';

class BookListHomePage extends StatefulWidget {
  BookListHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _BookListHomePageState createState() => _BookListHomePageState();
}

class _BookListHomePageState extends State<BookListHomePage> {
  bool bookMark = false;

  final _bookBloc = BooksBloc();
  GlobalKey bookListKey = GlobalKey();

  @override
  void dispose() {
    _bookBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => _bookBloc..add(LoadBookEvent()),
      child: BlocListener<BooksBloc, BooksState>(
        listener: (context, state) {},
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            return Scaffold(
              key: bookListKey,
              body: Stack(
                key: bookListKey,
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
                        title: "${widget.title} Book",
                      )),
                  // contain
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: containPage(screenHeight, screenWidth, state),
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
      double screenHeight, double screenWidth, BooksState state) {
    if (state is LoadedState) {
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
        child: state.bookList.length != 0
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: state.bookList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<BooksBloc>(bookListKey.currentContext)
                          .add(PressBtnMoveBookEvent(
                              context: context, book: state.bookList[index]));
                    },
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        // item object
                        ItemBook(
                          height: screenHeight,
                          width: screenWidth,
                          itemBook: state.bookList[index],
                        ),
                        // star
                        widget.title == "Trending"
                            ? Positioned(
                                top: screenHeight * 0.015,
                                left: screenWidth * 0.25,
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
              )
            : Container(
                child: Center(),
              ),
      );
    } else {
      return Scaffold(
        body: Container(),
      );
    }
  }
}
