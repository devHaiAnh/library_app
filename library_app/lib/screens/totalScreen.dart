import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/model/login_model.dart';
import 'package:library_app/screens/bookmark/bookMarkScreen.dart';
import 'package:library_app/screens/cart/cartScreen.dart';
import 'package:library_app/screens/home/homeScreen.dart';
import 'package:library_app/screens/member/memberListScreen.dart';
import 'package:library_app/screens/payment/paymentHistoryScreen.dart';

class TotalPage extends StatefulWidget {
  final Member member;
  TotalPage({Key key, @required this.member}) : super(key: key);
  @override
  _TotalPageState createState() => _TotalPageState();
}

class _TotalPageState extends State<TotalPage> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  GlobalKey _totalKey = GlobalKey();

  bool admin;

  HomePage _homePage;
  BookMarkPage _bookMarkPage;
  CartPage _cartPage;
  MemberListPage _memberListPage;
  PaymentHistoryPage _paymentListPage;

  Widget _home;

  @override
  void initState() {
    admin = widget.member.admin;
    _homePage = HomePage(model: widget.member);
    _bookMarkPage = BookMarkPage();
    _cartPage = CartPage();
    _memberListPage = MemberListPage();
    _paymentListPage = PaymentHistoryPage();
    _home = HomePage(model: widget.member);
    super.initState();
  }

  Widget _showChooserMember(int page) {
    switch (page) {
      case 0:
        return _bookMarkPage;
        break;
      case 1:
        return _homePage;
        break;
      case 2:
        return _cartPage;
        break;
      default:
        return Container(
          child: Center(
            child: Text("data"),
          ),
        );
        break;
    }
  }

  Widget _showChooserAdmin(int page) {
    switch (page) {
      case 0:
        return _bookMarkPage;
        break;
      case 1:
        return _memberListPage;
        break;
      case 2:
        return _homePage;
        break;
      case 3:
        return _cartPage;
        break;
      case 4:
        return _paymentListPage;
        break;
      default:
        return Container(
          child: Center(
            child: Text("data"),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _totalKey,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: admin ? 2 : 1,
        height: screenHeight * 0.07,
        items: admin ? adminBottomIcon : memberBottomIcon,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.grey[100],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _home =
                admin ? _showChooserAdmin(index) : _showChooserMember(index);
          });
        },
      ),
      body: Container(
        child: _home,
      ),
    );
  }

  List<Widget> memberBottomIcon = [
    Icon(Icons.bookmark, size: 20, color: Colors.purple[400]),
    Icon(Icons.home, size: 20, color: Colors.purple[400]),
    Icon(Icons.shopping_cart, size: 20, color: Colors.purple[400]),
  ];

  List<Widget> adminBottomIcon = [
    Icon(Icons.bookmark, size: 20, color: Colors.purple[400]),
    Icon(Icons.person, size: 20, color: Colors.purple[400]),
    Icon(Icons.home, size: 20, color: Colors.purple[400]),
    Icon(Icons.shopping_cart, size: 20, color: Colors.purple[400]),
    Icon(Icons.local_atm, size: 20, color: Colors.purple[400]),
  ];
}
