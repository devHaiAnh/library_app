import 'package:flutter/material.dart';
import 'package:library_app/data/model/book.dart';

class ItemBookCategory extends StatefulWidget {
  final double width, height;
  final Book itemBook;
  ItemBookCategory({Key key, this.width, this.itemBook, this.height})
      : super(key: key);
  @override
  _ItemBookCategoryState createState() => _ItemBookCategoryState();
}

class _ItemBookCategoryState extends State<ItemBookCategory> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(8),
          height: widget.height * 0.15,
          width: widget.width * 0.25,
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
                  height: widget.height * 0.17,
                  margin: EdgeInsets.only(left: widget.width * 0.03),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.itemBook.image,
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
                  margin: EdgeInsets.only(left: widget.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[bookMark(), data(), Container()],
                  ),
                ),
              ),
            ],
          ),
        ),
        // widget.itemBook.status == 3
        //     ? 
            Container()
            // : Positioned(
            //     top: widget.height * 0.043,
            //     left: widget.width * -0.025,
            //     child: widget.itemBook.status == 0
            //         ? bannerColor("green", "Reading")
            //         : widget.itemBook.status == 1
            //             ? bannerColor("blue", "Hiring")
            //             : bannerColor("violet", "Bought"))
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

  Widget bookMark() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(),
        InkWell(
          onTap: () {
            // setState(() {
            //   widget.itemBook.bookMark = !widget.itemBook.bookMark;
            //   // bookMark = !bookMark;
            // });
          },
          child: Container(
            // child: Icon(
            //   widget.itemBook.bookMark ? Icons.bookmark : Icons.bookmark_border,
            //   color: widget.itemBook.bookMark ? Colors.amber : Colors.grey,
            // ),
          ),
        ),
      ],
    ));
  }

  Widget data() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // name
          Text(
            widget.itemBook.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          SizedBox(height: widget.height * 0.01),
          // author
          Text(
            widget.itemBook.author,
            style: TextStyle(fontSize: 9),
          ),
          // star
          Container(
            height: widget.height * 0.03,
            child: Row(
              children: <Widget>[
                Text(
                  widget.itemBook.star.toString(),
                  style: TextStyle(fontSize: 9),
                ),
                Container(
                    height: widget.height * 0.015,
                    child:
                        Icon(Icons.star, size: 10, color: Colors.amberAccent))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
