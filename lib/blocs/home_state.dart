import 'package:equatable/equatable.dart';

 class HomeState extends Equatable {
   const HomeState();

  @override
  List<Object> get props => [];
}


class LoadInitial extends HomeState {
  const LoadInitial() : super();
}
class Loading extends HomeState {
  const Loading() : super();
}

class LoadDataSuccess extends HomeState {
  final dynamic data;

  const LoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => [data];
}

class LoadDataFail extends HomeState {
  final dynamic error;

  const LoadDataFail(this.error) : super();

  @override
  List<Object> get props => [error];
}