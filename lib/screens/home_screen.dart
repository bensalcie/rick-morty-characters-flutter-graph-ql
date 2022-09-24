import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rnm_graphql/blocs/home_bloc.dart';

import '../blocs/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('GraphQL Demo'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: const LinearProgressIndicator(),
          );
        } 
         if (state is LoadDataFail) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Center(child: Text(state.error)),
          );
        } 
         if (state is LoadDataSuccess) {

          data = state.data['characters']['results'];
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
          );


          
        }else{
          return Scaffold(
            appBar: _buildAppBar(),
            body: const Center(child: Text('Unknown')),
          );
        }
        
      },
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        var item = data[index];
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Text(item['id']),
            title: Text(item['name']),
            trailing: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: item['status'] == 'Dead'
                    ? Colors.red.withOpacity(0.3)
                    : item['status'] == 'Alive'
                        ? Colors.green.withOpacity(0.3)
                        : Colors.amber.withOpacity(0.3),
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Text(
                item['status'],
                style: TextStyle(
                    color: item['status'] == 'Dead'
                        ? Colors.red
                        : item['status'] == 'Alive'
                            ? Colors.green
                            : Colors.amber),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}