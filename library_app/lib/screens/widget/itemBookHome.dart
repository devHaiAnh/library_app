import 'package:flutter/material.dart';
import 'package:library_app/model/bookHome.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemBookHome extends StatefulWidget {
  final double height, width;
  final Book itemBook;
  ItemBookHome({Key key, this.height, this.width, this.itemBook})
      : super(key: key);
  @override
  _ItemBookHomeState createState() => _ItemBookHomeState();
}

class _ItemBookHomeState extends State<ItemBookHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(widget.width * 0.02),
      width: widget.width * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: widget.height * 0.18,
            width: widget.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      widget.itemBook.image,
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(16)),
          ),
          SizedBox(height: widget.height * 0.01),
          Text(
            widget.itemBook.name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(widget.itemBook.author, style: TextStyle(fontSize: 10)),
          Container(
            padding: EdgeInsets.only(top: widget.height * 0.005),
            height: widget.height * 0.025,
            child: SmoothStarRating(
              rating: widget.itemBook.star,
              size: 12,
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
        ],
      ),
    );
  }
}
