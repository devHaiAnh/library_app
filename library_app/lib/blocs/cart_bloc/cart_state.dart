part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

// load listview
class LoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class RefreshState extends CartState {
  @override
  List<Object> get props => [];
}

class LoadedState extends CartState {
  final List<Cart> cartList;
  LoadedState({@required this.cartList});
  @override
  List<Object> get props => [cartList];
}

class SuccessState extends CartState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends CartState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}
