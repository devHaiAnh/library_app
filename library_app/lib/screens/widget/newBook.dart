import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/books_bloc/books_bloc.dart';
import 'package:library_app/screens/book/bookScreen.dart';
import 'package:library_app/screens/home/bookListCategory.dart';
import 'package:library_app/screens/widget/itemBookHome.dart';

class NewBook extends StatefulWidget {
  final double width, height;
  NewBook({this.width, this.height});
  @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final _bookBloc = BooksBloc();
  final String category = "Life skills";
  @override
  void dispose() {
    _bookBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          _bookBloc..add(LoadBookCategoryEvent(category: category)),
      child: BlocListener<BooksBloc, BooksState>(
        listener: (context, state) async {
          if (state is SuccessState) {
            BlocProvider.of<BooksBloc>(context)
                .add(LoadBookCategoryEvent(category: category));
          } else if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          } else if (state is MoveAllBookState) {
            await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookListCategory(title: "New", category: category)))
                .then((value) => BlocProvider.of<BooksBloc>(context)
                    .add(LoadBookCategoryEvent(category: category)));
          } else if (state is MoveBookState) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookPage(book: state.book)),
            ).then((value) => BlocProvider.of<BooksBloc>(context)
                .add(LoadBookCategoryEvent(category: category)));
          }
        },
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            if (state is LoadedBookState) {
              return Container(
                height: widget.height * 0.37,
                width: widget.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: widget.width * 0.05,
                          right: widget.width * 0.05,
                          bottom: widget.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "New Book",
                            style:
                                TextStyle(fontSize: 25, color: Colors.purple),
                          ),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<BooksBloc>(context)
                                  .add(MoveAllBookEvent(title: "New"));
                            },
                            child: Text(
                              "See all",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: widget.height * 0.31,
                      width: widget.width,
                      padding: EdgeInsets.all(widget.width * 0.02),
                      margin: EdgeInsets.only(left: widget.width * 0.05),
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
                            height: widget.height * 0.285,
                            width: widget.width * 0.92,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state?.bookList?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<BooksBloc>(context).add(
                                        MoveBookEvent(
                                            book: state.bookList[index]));
                                  },
                                  child: ItemBookHome(
                                    width: widget.width,
                                    height: widget.height,
                                    itemBook: state.bookList[index],
                                    function: (v) {
                                      BlocProvider.of<BooksBloc>(context).add(
                                          PressBookmarkEvent(
                                              book: state.bookList[index],
                                              context: context));
                                    },
                                  ),
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
            } else {
              return Container(
                height: widget.height * 0.37,
                width: widget.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: widget.width * 0.05,
                          right: widget.width * 0.05,
                          bottom: widget.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "New Book",
                            style:
                                TextStyle(fontSize: 25, color: Colors.purple),
                          ),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<BooksBloc>(context)
                                  .add(MoveAllBookEvent(title: "New"));
                            },
                            child: Text(
                              "See all",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: widget.height * 0.31,
                      width: widget.width,
                      padding: EdgeInsets.all(widget.width * 0.02),
                      margin: EdgeInsets.only(left: widget.width * 0.05),
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
                            height: widget.height * 0.285,
                            width: widget.width * 0.92,
                            // child: Center(
                            //   child: Text("/* No book */"),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
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
