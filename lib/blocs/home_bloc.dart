import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rnm_graphql/services/graphql_service.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
 late GraphQLService service;

  HomeBloc() : super(const LoadInitial())  {
    service = GraphQLService();
    on<FetchHomeData>(_mapFetchHomeDataToStates);
  }

  HomeState get initialState => const Loading();

 

  _mapFetchHomeDataToStates(
     FetchHomeData event,
    Emitter<HomeState> emit,) async {
    final query = event.query;
     final Map<String, dynamic>? variables;
  variables = event.variables;

    try {
      emit(const Loading());
      final result = await service.performMutation(query, variables: variables??{});

      if (result.hasException) {
        print('graphQLErrors: ${result.exception?.graphqlErrors.toString()}');
        print('clientErrors: ${result.exception?.linkException.toString()}');
        emit(LoadDataFail(result.exception?.graphqlErrors[0]));
      } else {
        emit(LoadDataSuccess(result.data)) ;
      }
    } catch (e) {
      print(e);
      emit(LoadDataFail(e.toString())) ;
    }
  }
}