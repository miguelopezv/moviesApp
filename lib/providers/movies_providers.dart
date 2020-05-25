import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = 'cde0f71de46966804562ea0f1ae62a6b';
  String _url = 'api.themoviedb.org';
  String _lang = 'en-US';

  Future<List<Movie>> _getData(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _lang,
    });

    return await _getData(url);
  }

  Future<List<Movie>> getPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _lang,
    });

    return await _getData(url);
  }
}