import 'package:flutter/material.dart';

class AppBarApp extends StatefulWidget {
  final String title;
  final int buttonBack;
  final double width, height;
  AppBarApp({Key key, this.buttonBack, this.width, this.height, this.title})
      : super(key: key);
  @override
  _AppBarAppState createState() => _AppBarAppState();
}

class _AppBarAppState extends State<AppBarApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: true,
      right: true,
      child: Container(
        height: widget.height * 0.08,
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.buttonBack == 0
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: widget.width * 0.08,
                            height: widget.width * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                                child: Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                            ))),
                      ),
                Container()
              ],
            ),
            // Spacer(),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: widget.height * 0.06,
                width: widget.width * 0.4,
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
                child: Center(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
