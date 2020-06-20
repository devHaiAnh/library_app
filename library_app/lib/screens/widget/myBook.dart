import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/payment_bloc/payment_bloc.dart';
import 'package:library_app/configs/configsApp.dart';
import 'package:library_app/screens/payment/paymentHistoryMemberScreen.dart';
import 'package:library_app/screens/widget/itemBookHomePayment.dart';
import 'package:library_app/screens/widget/qrScreen.dart';

class MyBook extends StatefulWidget {
  final double width, height;
  MyBook({this.width, this.height});
  @override
  _MyBookState createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
  final _paymentBloc = PaymentBloc();
  @override
  void dispose() {
    _paymentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _paymentBloc
        ..add(LoadPaymentMemberEvent(username: ConfigsApp.userName)),
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {},
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
              if (state is LoadedPaymentState) {
                return state.paymentList.length != 0
                    ? Container(
                        height: widget.height * 0.37,
                        width: widget.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: widget.width * 0.05,
                                  right: widget.width * 0.05,
                                  bottom: widget.width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "My Book",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.purple),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentHistoryMemberPage(
                                            username: ConfigsApp.userName,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "See all",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: widget.height * 0.3,
                              margin:
                                  EdgeInsets.only(left: widget.width * 0.03),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state?.paymentList?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QRPage(
                                            data:
                                                state.paymentList[index].name +
                                                    state.paymentList[index]
                                                        .username,
                                            registed: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: ItemBookHomePayment(
                                      width: widget.width,
                                      height: widget.height,
                                      itemPayment: state.paymentList[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container();
              } else {
                return Container();
              }
            });
          },
        ),
      ),
    );
  }
}
