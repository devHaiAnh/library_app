import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/screens/firstScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
