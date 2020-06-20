import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_app/data/model/payments_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemBookHomePayment extends StatefulWidget {
  final double width, height;
  final Payment itemPayment;
  ItemBookHomePayment(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.itemPayment})
      : super(key: key);
  @override
  _ItemBookHomePaymentState createState() => _ItemBookHomePaymentState();
}

class _ItemBookHomePaymentState extends State<ItemBookHomePayment> {
  GlobalKey itemPaymentKey = GlobalKey();

  final dayFormat = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: itemPaymentKey,
      height: widget.height * 0.3,
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
            flex: 4,
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
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.5),
      //       spreadRadius: 1,
      //       blurRadius: 6,
      //       offset: Offset(0, 3), // changes position of shadow
      //     ),
      //   ],
      //   image: DecorationImage(
      //       image: NetworkImage(widget.itemPayment.image), fit: BoxFit.cover),
      // ),
      child: CachedNetworkImage(
        imageUrl: widget.itemPayment.image,
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
              rating: widget.itemPayment.evaluateBook,
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
            child: Text(
              widget.itemPayment.status == 3
                  ? "Date of purchase: "
                  : widget.itemPayment.status == 2
                      ? "Registration Date: "
                      : "Start Reading Date: ",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
          Container(
            child: Text(
              dayFormat.format(new DateTime.fromMillisecondsSinceEpoch(
                  widget.itemPayment.registrationDate)),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          SizedBox(height: widget.height * 0.01),
          Container(
            child: Text(
              widget.itemPayment.status == 3
                  ? "Count: "
                  : widget.itemPayment.status == 2
                      ? "Expiration Date: "
                      : "Final Date: ",
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
          Container(
            child: Text(
              widget.itemPayment.status == 3
                  ? widget.itemPayment.count.toString()
                  : dayFormat.format(new DateTime.fromMillisecondsSinceEpoch(
                      widget.itemPayment.expirationDate)),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          // SizedBox(height: widget.height * 0.005),
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
                  widget.itemPayment.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: widget.height * 0.001),
                Text(
                  widget.itemPayment.author,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            width: widget.width * 0.1,
            // height: widget.width * 0.2,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.itemPayment.status == 3
                        ? Colors.purple
                        : widget.itemPayment.status == 2
                            ? Colors.blue
                            : Colors.green),
                borderRadius: BorderRadius.circular(32)),
            child: Center(
              child: Text(
                widget.itemPayment.status == 3
                    ? "Bought"
                    : widget.itemPayment.status == 2 ? "Lending" : "Reading",
                style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: widget.itemPayment.status == 3
                        ? Colors.purple
                        : widget.itemPayment.status == 2
                            ? Colors.blue
                            : Colors.green),
              ),
            ),
          )
          // InkWell(
          //   onTap: () {
          //     // BlocProvider.of<CartBloc>(itemPaymentKey.currentContext).add(
          //     //     PressButtonDelCartEvent(
          //     //         context: context, name: widget.itemPayment.name));
          //   },
          //   child: Container(
          //     width: widget.width * 0.07,
          //     height: widget.width * 0.07,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: Colors.red),
          //         borderRadius: BorderRadius.circular(24)),
          //     child: Icon(Icons.close, color: Colors.red),
          //   ),
          // )
        ],
      ),
    );
  }
}
