import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:library_app/data/model/carts_model.dart';
import 'package:library_app/screens/widget/appbarApp.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cartBloc = CartBloc();
  GlobalKey cartKey = GlobalKey();

  @override
  void dispose() {
    _cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => _cartBloc..add(LoadCartEvent()),
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is SuccessState) {
            BlocProvider.of<CartBloc>(context).add(LoadCartEvent());
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Scaffold(
              key: cartKey,
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
                        buttonBack: 0,
                        width: screenWidth,
                        height: screenHeight,
                        title: "Your Cart",
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

  Widget containPage(double screenHeight, double screenWidth, CartState state) {
    if (state is LoadedState) {
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
            borderRadius: BorderRadius.circular(40)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
              child: Container(
                child: state.cartList.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.cartList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ), //this right here
                                        child: DialogCart(
                                            cart: state.cartList[index]));
                                  },
                                );
                              },
                              child:
                                  // ItemBookCart(
                                  //   height: screenHeight,
                                  //   width: screenWidth,
                                  //   itemCart: state.cartList[index],
                                  // ),
                                  Container(
                                height: screenHeight * 0.25,
                                padding: EdgeInsets.all(screenWidth * 0.025),
                                margin: EdgeInsets.all(screenWidth * 0.02),
                                width: screenWidth * 0.7,
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
                                child: Row(
                                  children: <Widget>[
                                    // image
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        width: screenWidth,
                                        height: screenHeight,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  state.cartList[index].image),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    // contain
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: screenWidth * 0.025),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            // name / author + bookmark
                                            Container(
                                              width: screenWidth,
                                              height: screenHeight * 0.06,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          state.cartList[index]
                                                              .name,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.001),
                                                        Text(
                                                          state.cartList[index]
                                                              .author,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<CartBloc>(
                                                              cartKey
                                                                  .currentContext)
                                                          .add(
                                                              PressButtonDelCartEvent(
                                                                  context:
                                                                      context,
                                                                  name: state
                                                                      .cartList[
                                                                          index]
                                                                      .name));
                                                      BlocProvider.of<CartBloc>(
                                                              cartKey
                                                                  .currentContext)
                                                          .add(LoadCartEvent());
                                                    },
                                                    child: Container(
                                                      width: screenWidth * 0.07,
                                                      height:
                                                          screenWidth * 0.07,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.red),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24)),
                                                      child: Icon(Icons.close,
                                                          color: Colors.red),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // star ranking
                                            Container(
                                              height: screenHeight * 0.02,
                                              child: SmoothStarRating(
                                                rating: state.cartList[index]
                                                    .evaluateBook,
                                                size: 15,
                                                filledIconData: Icons.star,
                                                halfFilledIconData:
                                                    Icons.star_half,
                                                defaultIconData:
                                                    Icons.star_border,
                                                starCount: 5,
                                                allowHalfRating: true,
                                                spacing: 2.0,
                                                color: Colors.yellow[600],
                                                borderColor: Colors.yellow[600],
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            // description
                                            Container(
                                                height: screenHeight * 0.06,
                                                child: Text(
                                                  state.cartList[index]
                                                      .description,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )),
                                            SizedBox(
                                                height: screenHeight * 0.005),
                                            // button
                                            Container(
                                                height: screenHeight * 0.045,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    // count
                                                    Container(
                                                      width: screenWidth * 0.2,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              child: Center(
                                                                child: Text(
                                                                  "Count: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                              .purple[
                                                                          300]),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              child: Center(
                                                                child: Text(
                                                                  state
                                                                      .cartList[
                                                                          index]
                                                                      .count
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .purple,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // cost
                                                    Text(
                                                      "\$ ${state.cartList[index].cost.toStringAsFixed(2)}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.purple,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )),
                                            SizedBox(
                                                height: screenHeight * 0.005),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      )
                    : Container(),
              ),
            ),
            // button pay
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        for (var i = 0; i < state.cartList.length; i++) {
                          BlocProvider.of<CartBloc>(cartKey.currentContext).add(
                              PressButtonAddPaymentEvent(
                                  cart: state.cartList[i], context: context));
                        }
                      },
                      child: Container(
                        width: screenWidth * 0.3,
                        decoration: BoxDecoration(
                          color: state.cartList.length == 0
                              ? Colors.grey
                              : Colors.purple[400],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                            child: Text(
                          "Pay all",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Total: ",
                          style: TextStyle(
                              fontSize: 15, color: Colors.purple[300]),
                        ),
                        Text(
                          "\$ ${sumPrice(state.cartList).toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Container(
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
              borderRadius: BorderRadius.circular(40)),
        ),
      );
    }
  }

  double sumPrice(list) {
    double data = 0;
    for (int i = 0; i < list.length; i++) {
      data += list[i].cost;
    }
    return data;
  }
}

class DialogCart extends StatefulWidget {
  final Cart cart;
  DialogCart({@required this.cart});
  @override
  _DialogCartState createState() => _DialogCartState();
}

class _DialogCartState extends State<DialogCart> {
  int count;
  @override
  void initState() {
    super.initState();
    count = widget.cart.count;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CartBloc(),
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {},
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Container(
              height: screenHeight * 0.3,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.03),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(PressButtonBackEvent(context: context));
                        },
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              countCart(screenHeight, screenWidth),
                              Text(
                                "\$ ${(widget.cart.cost * count).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        // button
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              // button sure
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<CartBloc>(context).add(
                                        PressButtonUpdateCartEvent(
                                            cost: widget.cart.cost * count,
                                            count: count,
                                            name: widget.cart.name,
                                            context: context));
                                    BlocProvider.of<CartBloc>(context).add(
                                        PressButtonBackEvent(context: context));
                                  },
                                  child: Container(
                                    height: screenHeight * 0.065,
                                    margin: EdgeInsets.only(
                                        right: screenWidth * 0.01),
                                    decoration: BoxDecoration(
                                        color: Colors.red[400],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Center(
                                      child: Text(
                                        "Confirm",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget countCart(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.25,
      child: Container(
        width: screenWidth * 0.25,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.purple),
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (count > 1) {
                      count--;
                    }
                  });
                },
                child: Container(
                  child: Icon(Icons.navigate_before, color: Colors.purple[300]),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: Text(
                    count.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.purple[300]),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (count < 99) {
                      count++;
                    }
                  });
                },
                child: Container(
                  child: Icon(Icons.navigate_next, color: Colors.purple[300]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
