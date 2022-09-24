import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeData extends HomeEvent {
  final String query;
  final Map<String, dynamic>? variables;

   const FetchHomeData(this.query, { this.variables}) : super();

  @override
  List<Object> get props => [ query, variables??{}];
}