part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

// Read
class LoadPaymentEvent extends PaymentEvent {
  @override
  List<Object> get props => [];
}

class LoadPaymentMemberEvent extends PaymentEvent {
  final String username;
  LoadPaymentMemberEvent({@required this.username});
  @override
  List<Object> get props => [username];
}

class OnReFreshPaymentEvent extends PaymentEvent {
  @override
  List<Object> get props => [];
}

// delete payment
class PressButtonDelPaymentEvent extends PaymentEvent {
  final String name;
  final BuildContext context;
  PressButtonDelPaymentEvent({@required this.name, @required this.context});
  @override
  List<Object> get props => [name];
}

// button back
class PressButtonBackEvent extends PaymentEvent {
  final BuildContext context;
  PressButtonBackEvent({@required this.context});
  @override
  List<Object> get props => [];
}

class MovePaymentEvent extends PaymentEvent {
  final String data;
  final bool registed;
  MovePaymentEvent({this.data, this.registed});
  @override
  List<Object> get props => [data, registed];
}
