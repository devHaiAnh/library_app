import 'package:flutter/material.dart';
import 'package:library_app/data/model/order.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemBookOrder extends StatefulWidget {
  final double width, height;
  final Order itemOrder;
  ItemBookOrder({Key key, this.height, this.itemOrder, this.width})
      : super(key: key);
  @override
  _ItemBookOrderState createState() => _ItemBookOrderState();
}

class _ItemBookOrderState extends State<ItemBookOrder> {
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

  Widget image() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(widget.itemOrder.image), fit: BoxFit.cover),
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
              rating: widget.itemOrder.star,
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
          // Registration date
          Container(
            height: widget.height * 0.03,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Registration date: ",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  TextSpan(
                    text: widget.itemOrder.registrationDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.01),
          // Expiration date
          Container(
            height: widget.height * 0.03,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Member: ",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  TextSpan(
                    text: "member",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.01),
          // Status
          Container(
            height: widget.height * 0.03,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Style: ",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  TextSpan(
                    text: widget.itemOrder.status == 0
                        ? "Reading"
                        : widget.itemOrder.status == 1 ? "Hiring" : "Bought",
                    style: TextStyle(
                        color: widget.itemOrder.status == 0
                            ? Colors.green
                            : widget.itemOrder.status == 1
                                ? Colors.blue
                                : Colors.purple[400],
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  )
                ],
              ),
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
                  widget.itemOrder.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: widget.height * 0.001),
                Text(
                  widget.itemOrder.author,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            child: Icon(Icons.info, color: Colors.black38),
          )
        ],
      ),
    );
  }
}
