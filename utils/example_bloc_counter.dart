import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(home: CounterPage(), debugShowCheckedModeBanner: false),
    );

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _incrementCounter() {
    counter++;
    _streamController.sink.add(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text(snapshot.data.toString());
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(''),
        onPressed: () {
          _incrementCounter();
        },
      ),
    );
  }
}
