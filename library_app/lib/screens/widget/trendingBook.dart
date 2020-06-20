import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/books_bloc/books_bloc.dart';
import 'package:library_app/screens/book/bookScreen.dart';
import 'package:library_app/screens/home/bookListCategory.dart';
import 'package:library_app/screens/widget/itemBookHome.dart';

class TrendingBook extends StatefulWidget {
  final double height, width;
  TrendingBook({this.height, this.width});
  @override
  _TrendingBookState createState() => _TrendingBookState();
}

class _TrendingBookState extends State<TrendingBook> {
  final _bookBloc = BooksBloc();
  @override
  void dispose() {
    _bookBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          _bookBloc..add(LoadBookCategoryEvent(category: "History")),
      child: BlocListener<BooksBloc, BooksState>(
        listener: (context, state) {},
        child: BlocBuilder<BooksBloc, BooksState>(builder: (context, state) {
          if (state is LoadedBookState) {
            return Container(
              // key: bookKey,
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
                          "Trending",
                          style: TextStyle(fontSize: 25, color: Colors.purple),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookListCategory(
                                        title: "Trending",
                                        category: "History",
                                        function: (v) {
                                          v
                                              ? BlocProvider.of<BooksBloc>(
                                                      context)
                                                  .add(LoadBookCategoryEvent(
                                                      category: "History"))
                                              : BlocProvider.of<BooksBloc>(
                                                      context)
                                                  .add(LoadBookCategoryEvent(
                                                      category: "History"));
                                        })));
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
                            // itemCount: state?.bookList?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookPage(
                                          book: state.bookList[index],
                                          function: (v) {
                                            setState(() {
                                              state.bookList[index].bookmark =
                                                  v;
                                            });
                                          }),
                                    ),
                                  );
                                },
                                child: ItemBookHome(
                                  width: widget.width,
                                  height: widget.height,
                                  itemBook: state.bookList[index],
                                  function: (v) {
                                    v
                                        ? BlocProvider.of<BooksBloc>(context)
                                            .add(PressBookmarkEvent(
                                                book: state.bookList[index],
                                                context: context))
                                        : BlocProvider.of<BooksBloc>(context)
                                            .add(PressBookmarkEvent(
                                                book: state.bookList[index],
                                                context: context));
                                    BlocProvider.of<BooksBloc>(context).add(
                                        LoadBookCategoryEvent(
                                            category: "History"));
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
              // key: bookKey,
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
                          "Trending",
                          style: TextStyle(fontSize: 25, color: Colors.purple),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => BookListHomePage(
                            //             title: "Trending",
                            //             function: (v) {
                            //               v
                            //                   ? BlocProvider.of<BooksBloc>(
                            //                           context)
                            //                       .add(LoadBookCategoryEvent(category: "History"))
                            //                   : BlocProvider.of<BooksBloc>(
                            //                           context)
                            //                       .add(LoadBookCategoryEvent(category: "History"));
                            //             })));
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
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
