import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  QRPage({Key key, this.data}) : super(key: key);
  final String data;
  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.grey[100],
            ),
          ),
          // contain
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: screenHeight * 0.4,
                      child: QrImage(data: widget.data)),
                  SizedBox(height: screenHeight * 0.05),
                  Text("You can use this QR code \nto confirm at the librarian",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                ],
              ),
            ),
          ),
          // appbar
          Positioned(
            top: 0,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: SafeArea(
              top: true,
              left: true,
              right: true,
              child: Container(
                height: screenHeight * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                    Container()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
