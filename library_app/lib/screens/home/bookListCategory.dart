import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/books_bloc/books_bloc.dart';
import 'package:library_app/screens/book/bookScreen.dart';
import 'package:library_app/screens/widget/itemBook.dart';

class BookListCategory extends StatefulWidget {
  final String title;
  final String category;
  BookListCategory({this.title, this.category});
  @override
  _BookListCategoryState createState() => _BookListCategoryState();
}

class _BookListCategoryState extends State<BookListCategory> {
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
      create: (context) =>
          _bookBloc..add(LoadBookCategoryEvent(category: widget.category)),
      child: BlocListener<BooksBloc, BooksState>(
        listener: (context, state) async {
          if (state is SuccessState) {
            BlocProvider.of(context)
                .add(LoadBookCategoryEvent(category: widget.category));
          } else if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          } else if (state is MoveBookState) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookPage(book: state.book)),
            ).then((value) => BlocProvider.of<BooksBloc>(context)
                .add(LoadBookCategoryEvent(category: widget.category)));
          }
        },
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            return Scaffold(
              key: bookListKey,
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
                      child: Stack(
                        children: <Widget>[
                          Row(
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
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
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
                                  "${widget.title} Book",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                        ],
                      ),
                    ),
                  ),
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
    if (state is LoadedBookState) {
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
                      BlocProvider.of<BooksBloc>(context)
                          .add(MoveBookEvent(book: state.bookList[index]));
                    },
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        // item object
                        ItemBook(
                            height: screenHeight,
                            width: screenWidth,
                            itemBook: state.bookList[index]),
                        // star
                        widget.title == "Trending"
                            ? Positioned(
                                top: screenHeight * 0.015,
                                left: screenWidth * 0.003,
                                child: Container(
                                  width: screenWidth * 0.09,
                                  height: screenWidth * 0.09,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/star.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  );
                },
              )
            : Container(),
      );
    } else {
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
          ),
        ),
      );
    }
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
