import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:library_app/data/model/bookmarks_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemBookmark extends StatelessWidget {
  final double height, width;
  final Bookmark itemBook;
  final Function function;
  ItemBookmark({this.height, this.width, this.itemBook, this.function});

  // GlobalKey itemBookKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Stack(
      // key: itemBookKey,
      fit: StackFit.passthrough,
      children: <Widget>[
        Container(
          height: height * 0.25,
          padding: EdgeInsets.all(width * 0.025),
          margin: EdgeInsets.all(width * 0.02),
          width: width * 0.7,
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
            children: <Widget>[
              // image
              Expanded(
                flex: 3,
                child: image(),
              ),
              // contain
              Expanded(
                flex: 7,
                child: containPage(context),
              ),
            ],
          ),
        ),
        // itemBook.status == 3
        //     ? Container()
        //     : Positioned(
        //         top: height * 0.018,
        //         left: width * -0.025,
        //         child: itemBook.status == 0
        //             ? bannerColor("green", "Reading")
        //             : itemBook.status == 1
        //                 ? bannerColor("blue", "Hiring")
        //                 : bannerColor("violet", "Bought"))
      ],
    );
  }

  Widget bannerColor(String color, data) {
    return Container(
      width: width * 0.3,
      height: height * 0.05,
      padding: EdgeInsets.fromLTRB(width * 0.08, height * 0.022, 0, 0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/img/$color.png"), fit: BoxFit.cover),
      ),
      child: Text(
        data,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Container image() {
    return Container(
      width: width,
      height: height,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       image: NetworkImage(itemBook.image), fit: BoxFit.cover),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.5),
      //       spreadRadius: 1,
      //       blurRadius: 6,
      //       offset: Offset(0, 3), // changes position of shadow
      //     ),
      //   ],
      // ),
      child: CachedNetworkImage(
        imageUrl: itemBook.image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
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
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget containPage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: width * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // name / author + bookmark
          nameBookAuthor(),
          // star ranking
          Container(
            height: height * 0.02,
            child: SmoothStarRating(
              rating: itemBook.evaluateBook,
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
          SizedBox(height: height * 0.01),
          // description
          Container(
              height: height * 0.06,
              child: Text(
                itemBook.description,
                style: TextStyle(fontSize: 12),
              )),
          SizedBox(height: height * 0.015),
          // button
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogCart(
                    bookmark: itemBook,
                  );
                },
              );
            },
            child: Container(
              height: height * 0.05,
              width: width * 0.6,
              decoration: BoxDecoration(
                  color: Colors.purple[400],
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Text(
                  "Add Your Cart",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameBookAuthor() {
    return Container(
      width: width,
      height: height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemBook.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.001),
                Text(
                  itemBook.author,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              function(false);
            },
            child: Container(
              child: Icon(Icons.bookmark, color: Colors.amber),
            ),
          )
        ],
      ),
    );
  }
}

class DialogCart extends StatefulWidget {
  final Bookmark bookmark;
  DialogCart({@required this.bookmark});
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
      create: (context) => BookmarkBloc(),
      child: BlocListener<BookmarkBloc, BookmarkState>(
        listener: (context, state) {},
        child: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
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
                            BlocProvider.of<BookmarkBloc>(context)
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
                                  "\$ ${(widget.bookmark.cost * count).toStringAsFixed(2)}",
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
                                      BlocProvider.of<BookmarkBloc>(context)
                                          .add(PressButtonAddCartEvent(
                                              bookmark: widget.bookmark,
                                              count: count,
                                              cost:
                                                  widget.bookmark.cost * count,
                                              context: context));
                                      BlocProvider.of<BookmarkBloc>(context).add(
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
