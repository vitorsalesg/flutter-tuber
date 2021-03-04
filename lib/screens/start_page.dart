import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_app/services/youtube_api_service.dart';
import 'package:youtube_app/model/video_model.dart';

class StartPage extends StatefulWidget {
  final String search;
  StartPage(this.search);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  _listVideos(String search) {
    Api api = Api();
    return api.search(search);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listVideos(widget.search),
      builder: (contex, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Video video = snapshot.data[index];

                  return cardWidget(
                    video.id,
                    video.image,
                    video.title,
                    video.channel,
                  );
                },
              );
            } else {
              return Center(
                child: Text("Nenhum resultado encontrado."),
              );
            }

            break;
        }

        return Text('');
      },
    );
  }

  Widget cardWidget(videoId, String image, String title, String channel) {
    return GestureDetector(
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(
          apiKey: YOUTUBE_KEY,
          videoId: videoId,
          autoPlay: true,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.black, width: 0.1),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              )),
            ),
            ListTile(
              title: Text(title),
              subtitle: Text(channel),
            )
          ],
        ),
      ),
    );
  }
}
