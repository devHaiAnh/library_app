import 'package:flutter/material.dart';

class ImageLogin extends StatefulWidget {
  final double width, height;
  ImageLogin({Key key, this.height, this.width}) : super(key: key);
  @override
  _ImageLoginState createState() => _ImageLoginState();
}

class _ImageLoginState extends State<ImageLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Welcome to \nAhk Library",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: widget.height * 0.02),
          Container(
            padding: EdgeInsets.all(widget.width * 0.01),
            width: widget.width * 0.15,
            height: widget.width * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              "assets/img/logo.png",
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
