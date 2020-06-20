import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/model/books_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemBookHome extends StatefulWidget {
  final double height, width;
  final Book itemBook;
  final Function function;
  ItemBookHome({Key key, this.height, this.width, this.itemBook, this.function})
      : super(key: key);
  @override
  _ItemBookHomeState createState() => _ItemBookHomeState();
}

class _ItemBookHomeState extends State<ItemBookHome> {
  @override
  void initState() {
    super.initState();
    widget.itemBook.bookmark == null
        ? widget.itemBook.bookmark = false
        : print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(widget.width * 0.02),
          width: widget.width * 0.22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // image
              Container(
                height: widget.height * 0.18,
                width: widget.width,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: NetworkImage(
                //           widget.itemBook.image,
                //         ),
                //         fit: BoxFit.cover),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 1,
                //         blurRadius: 6,
                //         offset: Offset(0, 3), // changes position of shadow
                //       ),
                //     ],
                //     borderRadius: BorderRadius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: widget.itemBook.image,
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
                      borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: widget.height * 0.01),
              // name
              Text(
                widget.itemBook.name,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              // author
              Text(widget.itemBook.author, style: TextStyle(fontSize: 10)),
              // star ranking
              Container(
                padding: EdgeInsets.only(top: widget.height * 0.005),
                height: widget.height * 0.025,
                child: SmoothStarRating(
                  rating: widget.itemBook.evaluateBook,
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
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () {
              setState(() {
                widget.itemBook.bookmark = !widget.itemBook.bookmark;
                widget.function(widget.itemBook.bookmark);
              });
            },
            child: Container(
              // color: Colors.white.withOpacity(0.8),
              child: Icon(Icons.bookmark,
                  color: widget.itemBook.bookmark ? Colors.amber : Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
