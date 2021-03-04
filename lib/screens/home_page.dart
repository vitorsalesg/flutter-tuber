import 'package:flutter/material.dart';
import 'package:youtube_app/model/customSearchDelegate.dart';
import 'package:youtube_app/screens/top_videos_page.dart';
import 'package:youtube_app/screens/start_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indiceAtual = 0;
  String resultSearch = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      StartPage(resultSearch),
      TopVideosPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );

              setState(() => resultSearch = result);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: screens[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            label: "Início",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Em alta",
            icon: Icon(Icons.whatshot),
          ),
        ],
      ),
    );
  }
}
