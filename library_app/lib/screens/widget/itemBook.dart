import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:library_app/data/model/book.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemBook extends StatefulWidget {
  final double height, width;
  final Book itemBook;
  ItemBook({Key key, this.height, this.width, this.itemBook}) : super(key: key);

  @override
  _ItemBookState createState() => _ItemBookState();
}

class _ItemBookState extends State<ItemBook> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Container(
          height: widget.height * 0.25,
          padding: EdgeInsets.all(widget.width * 0.025),
          margin: EdgeInsets.all(widget.width * 0.02),
          width: widget.width * 0.7,
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
                child: containPage(),
              ),
            ],
          ),
        ),
        widget.itemBook.status == 3
            ? Container()
            : Positioned(
                top: widget.height * 0.018,
                left: widget.width * -0.025,
                child: widget.itemBook.status == 0
                    ? bannerColor("green", "Reading")
                    : widget.itemBook.status == 1
                        ? bannerColor("blue", "Hiring")
                        : bannerColor("violet", "Bought"))
      ],
    );
  }

  Widget bannerColor(String color, data) {
    return Container(
      width: widget.width * 0.3,
      height: widget.height * 0.05,
      padding:
          EdgeInsets.fromLTRB(widget.width * 0.08, widget.height * 0.022, 0, 0),
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
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(widget.itemBook.image), fit: BoxFit.cover),
      ),
    );
  }

  Widget containPage() {
    return Container(
      padding: EdgeInsets.only(left: widget.width * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // name / author + bookmark
          nameBookAuthor(),
          // star ranking
          Container(
            height: widget.height * 0.02,
            child: SmoothStarRating(
              rating: widget.itemBook.star,
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
          SizedBox(height: widget.height * 0.01),
          // description
          Container(
              height: widget.height * 0.06,
              child: Text(
                widget.itemBook.description,
                style: TextStyle(fontSize: 12),
              )),
          SizedBox(height: widget.height * 0.005),
          // button
          Container(
            height: widget.height * 0.05,
            width: widget.width * 0.6,
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
        ],
      ),
    );
  }

  Container nameBookAuthor() {
    return Container(
      width: widget.width,
      height: widget.height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.itemBook.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: widget.height * 0.001),
                Text(
                  widget.itemBook.author,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.itemBook.bookMark = !widget.itemBook.bookMark;
              });
            },
            child: Container(
              child: Icon(
                  widget.itemBook.bookMark
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: widget.itemBook.bookMark ? Colors.amber : Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
