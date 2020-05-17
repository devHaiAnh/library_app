import 'package:flutter/material.dart';
import 'package:library_app/model/bookHome.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemBookCart extends StatefulWidget {
  final double width, height;
  final Book itemBook;
  ItemBookCart({Key key, this.width, this.height, this.itemBook})
      : super(key: key);
  @override
  _ItemBookCartState createState() => _ItemBookCartState();
}

class _ItemBookCartState extends State<ItemBookCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              height: widget.height * 0.045,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  countBook(),
                  Text(
                    "\$ 77",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
          SizedBox(height: widget.height * 0.005),
        ],
      ),
    );
  }

  Widget countBook() {
    return Container(
      width: widget.width * 0.25,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(Icons.navigate_before, color: Colors.purple[300]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Text(
                  "3",
                  style: TextStyle(fontSize: 14, color: Colors.purple[300]),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(Icons.navigate_next, color: Colors.purple[300]),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameBookAuthor() {
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
              
            },
            child: Container(
              width: widget.width * 0.07,
              height: widget.width * 0.07,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(24)),
              child: Icon(Icons.close, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
