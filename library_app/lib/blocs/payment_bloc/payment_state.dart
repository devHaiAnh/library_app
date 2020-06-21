part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}

// load listview
class LoadingState extends PaymentState {
  @override
  List<Object> get props => [];
}

class RefreshState extends PaymentState {
  @override
  List<Object> get props => [];
}

class LoadedPaymentState extends PaymentState {
  final List<Payment> paymentList;
  LoadedPaymentState({@required this.paymentList});
  @override
  List<Object> get props => [paymentList];
}

class SuccessState extends PaymentState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends PaymentState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}

class MovePaymentState extends PaymentState {
  final String data;
  final bool registed;
  MovePaymentState({this.data, this.registed});
  @override
  List<Object> get props => [data,registed];
}
