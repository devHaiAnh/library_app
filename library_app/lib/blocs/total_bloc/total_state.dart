part of 'total_bloc.dart';

abstract class TotalState extends Equatable {
  const TotalState();
}

class TotalInitial extends TotalState {
  @override
  List<Object> get props => [];
}

class ErrorState extends TotalState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}