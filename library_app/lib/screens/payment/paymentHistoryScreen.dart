import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/payment_bloc/payment_bloc.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:library_app/screens/widget/itemBookPayment.dart';
import 'package:library_app/screens/widget/qrScreen.dart';

class PaymentHistoryPage extends StatefulWidget {
  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  final _paymentBloc = PaymentBloc();
  GlobalKey paymentKey = GlobalKey();

  @override
  void dispose() {
    _paymentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => _paymentBloc..add(LoadPaymentEvent()),
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) async {
          if (state is ErrorState) {
            _showDialog(context, state.errorTitle, state.errorMessage);
          } else if (state is MovePaymentState) {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QRPage(
                        data: state.data,
                        registed: state.registed))).then((value) =>
                BlocProvider.of<PaymentBloc>(context).add(LoadPaymentEvent()));
          }
        },
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return Scaffold(
              key: paymentKey,
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
                  // appbar
                  Positioned(
                      top: 0,
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      child: AppBarApp(
                        width: screenWidth,
                        height: screenHeight,
                        buttonBack: 0,
                        title: "All Payment List",
                      )),
                  // contain
                  Positioned(
                    top: screenHeight * 0.12,
                    left: 0,
                    right: 0,
                    bottom: screenHeight * 0.005,
                    child: containPage(screenHeight, screenWidth, state),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget containPage(
      double screenHeight, double screenWidth, PaymentState state) {
    if (state is LoadedPaymentState) {
      return Container(
        height: screenHeight * 0.88,
        padding: EdgeInsets.all(screenWidth * 0.05),
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.paymentList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                BlocProvider.of<PaymentBloc>(paymentKey.currentContext).add(
                    MovePaymentEvent(
                        data: state.paymentList[index].name +
                            state.paymentList[index].username,
                        registed: true));
              },
              child: ItemBookPayment(
                  height: screenHeight,
                  width: screenWidth,
                  itemPayment: state.paymentList[index]),
            );
          },
        ),
      );
    } else {
      return Container(
        height: screenHeight * 0.88,
        padding: EdgeInsets.all(screenWidth * 0.05),
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
      );
    }
  }

  _showDialog(BuildContext mainContext, String title, String message) async {
    await showDialog(
      context: mainContext,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
