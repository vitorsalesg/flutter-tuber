import 'package:flutter/material.dart';

class TopVideosPage extends StatefulWidget {
  @override
  _TopVideosPageState createState() => _TopVideosPageState();
}

class _TopVideosPageState extends State<TopVideosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Em Alta",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
