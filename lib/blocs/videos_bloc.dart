import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';
import 'package:youtube_app/model/video_model.dart';
import 'package:youtube_app/services/api.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<VideoModel> videos;

  final StreamController<List<VideoModel>> _videosController =
      StreamController<List<VideoModel>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
