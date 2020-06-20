import 'package:flutter/material.dart';
import 'package:library_app/data/model/category.dart';
import 'package:library_app/screens/home/categoryBookHome.dart';
import 'package:library_app/screens/home/categoryListHome.dart';
import 'package:library_app/screens/widget/itemCategoryHome.dart';

class Category extends StatefulWidget {
  final double width, height;
  Category({this.width, this.height});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.26,
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
                  "Categories",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryListHomePage(),
                      ),
                    );
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
            height: widget.height * 0.2,
            width: widget.width,
            margin: EdgeInsets.only(left: widget.width * 0.05),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryBookHomePage(
                            category: categoryList[index].name),
                      ),
                    );
                  },
                  child: ItemCategoryHome(
                    width: widget.width,
                    height: widget.height,
                    itemCategoryBook: categoryList[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
