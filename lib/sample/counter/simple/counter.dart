import 'dart:async';

import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BloC Counter'),
      ),
      body: Center(
        child: StreamBuilder(
          builder: (context, snapshot) {
            return Text('${snapshot.data}');
          },
          stream: _streamController.stream,
          initialData: _counter,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _streamController.sink.add(++_counter);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
