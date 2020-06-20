import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:library_app/screens/widget/itemBookmark.dart';

class BookMarkPage extends StatefulWidget {
  @override
  _BookMarkPageState createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  final _bookmarkBloc = BookmarkBloc();
  GlobalKey bookmarkKey = GlobalKey();
  @override
  void dispose() {
    _bookmarkBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => _bookmarkBloc..add(LoadBookmarkEvent()),
      child: BlocListener<BookmarkBloc, BookmarkState>(
        listener: (context, state) {},
        child: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            return Scaffold(
              key: bookmarkKey,
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
                        title: "All Bookmark",
                      )),
                  // contain
                  Positioned(
                    top: screenHeight * 0.12,
                    left: 0,
                    right: 0,
                    bottom: screenHeight * 0.005,
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
      double screenHeight, double screenWidth, BookmarkState state) {
    if (state is LoadedBookmarkState) {
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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.bookmarkList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => BookPage(
                //               book: bookList[index],
                //             )));
              },
              child: ItemBookmark(
                height: screenHeight,
                width: screenWidth,
                itemBook: state.bookmarkList[index],
                function: (v) {
                  v
                      ? print("object")
                      : BlocProvider.of<BookmarkBloc>(context).add(
                          PressButtonDelBookmarkEvent(
                              bookmark: state.bookmarkList[index],
                              context: context),
                        );
                  BlocProvider.of<BookmarkBloc>(context).add(
                    LoadBookmarkEvent(),
                  );
                },
              ),
            );
          },
        ),
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
            borderRadius: BorderRadius.circular(40)),
      );
    }
  }
}
