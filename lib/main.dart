import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rnm_graphql/blocs/home_event.dart';
import 'package:rnm_graphql/screens/home_screen.dart';

import 'blocs/home_bloc.dart';
import 'blocs/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

String query = '''
  query {
    characters(page: 1) {
      results {
        id
        name
        status
      }
    }
  }
''';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc()..add(FetchHomeData(query)),
        child: const HomeScreen(),
      ),
    );
  }
}
