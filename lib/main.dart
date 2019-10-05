import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/config/request.dart';
import 'package:flutter_bloc_test/sample/infinite_list/bloc.dart';
import 'package:flutter_bloc_test/sample/infinite_list/post_page.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: BlocProvider<CounterBloc>(
//        builder: (context) => CounterBloc(),
//        child: CounterPage(),
//      ),
//      home: BlocProvider(
//        builder: (context) => TimerBloc(ticker: Ticker()),
//        child: Timer(),
//      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts BloC'),
        ),
        body: BlocProvider(
          builder: (context) {
            print("meme");
            return PostBloc(dio: crateDio())
              ..dispatch(FetchEvent());
          },
          child: HomePage(),
        ),
      ),
    );
  }
}
