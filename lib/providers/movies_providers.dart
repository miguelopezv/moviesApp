import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/models/actor_model.dart';
import 'package:movies/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = 'cde0f71de46966804562ea0f1ae62a6b';
  String _url = 'api.themoviedb.org';
  String _lang = 'en-US';
  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _movies = new List();
  final _popularMoviesStreamController =
      StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink =>
      _popularMoviesStreamController.sink.add;
  Stream<List<Movie>> get popularsStream =>
      _popularMoviesStreamController.stream;

  void disposeStream() {
    _popularMoviesStreamController?.close();
  }

// TODO: Refactor so that it can be used by all methods
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
    if (_loading) return [];

    _loading = true;
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _lang,
      'page': _popularsPage.toString()
    });

    final res = await _getData(url);

    _movies.addAll(res);

    popularsSink(_movies);

    _loading = false;

    // TODO: Remove this and update method
    return res;
  }

  Future<List<Actor>> getCast(int movieId) async {
    // TODO: move this to a _private variable
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _lang,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _lang,
      'query': query,
    });

    return await _getData(url);
  }
}
