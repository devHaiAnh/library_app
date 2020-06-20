import 'package:flutter/material.dart';
import 'package:library_app/data/model/category.dart';

class ItemCategoryHome extends StatefulWidget {
  final double width, height;
  final CategoryBook itemCategoryBook;
  ItemCategoryHome({Key key, this.height, this.width, this.itemCategoryBook})
      : super(key: key);
  @override
  _ItemCategoryHomeState createState() => _ItemCategoryHomeState();
}

class _ItemCategoryHomeState extends State<ItemCategoryHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            widget.itemCategoryBook.image,
            width: widget.width * 0.07,
            height: widget.height * 0.05,
            color: Colors.purple,
          ),
          Text(
            widget.itemCategoryBook.name,
            style: TextStyle(color: Colors.purple, fontSize: 15),
          ),
          // Text(
          //   "${widget.itemCategoryBook.count} books",
          //   style: TextStyle(color: Colors.purple, fontSize: 10),
          // )
        ],
      ),
    );
  }
}
