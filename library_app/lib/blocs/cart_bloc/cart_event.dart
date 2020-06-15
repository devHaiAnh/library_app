part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

// Read
class LoadCartEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class OnReFreshCartEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

// update cart
class PressButtonUpdateCartEvent extends CartEvent {
  final String name;
  final int count;
  final double cost;
  final BuildContext context;
  PressButtonUpdateCartEvent(
      {@required this.name,
      @required this.count,
      @required this.cost,
      @required this.context});
  @override
  List<Object> get props => [name, count, cost];
}

// delete cart
class PressButtonDelCartEvent extends CartEvent {
  final String name;
  final BuildContext context;
  PressButtonDelCartEvent({@required this.name, @required this.context});
  @override
  List<Object> get props => [name];
}

// add payment
class PressButtonAddPaymentEvent extends CartEvent {
  final Cart cart;
  final BuildContext context;
  PressButtonAddPaymentEvent({@required this.cart, @required this.context});
  @override
  List<Object> get props => [cart];
}

// button back
class PressButtonBackEvent extends CartEvent {
  final BuildContext context;
  PressButtonBackEvent({@required this.context});
  @override
  List<Object> get props => [];
}
