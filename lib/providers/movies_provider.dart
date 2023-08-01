import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '731c51e7c57b41a1dd7014d016fa56f8';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _sugestionStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._sugestionStreamController.stream;

  MoviesProvider() {
    getOnDisplayMovies();
    getOnDisplayPopularMovies();

  }

  Future<String> _getJsonData(String endpoint, int page) async {
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing', 1);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final nowPlayingResponse = NowPlayingResponse.fromJson(decodedData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getOnDisplayPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final popularResponse = PopularResponse.fromJson(decodedData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    final jsonData =
        await _getJsonData('3/movie/$movieId/credits', _popularPage);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final creditsResponse = CreditResponse.fromJson(decodedData);

    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    var url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromRawJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie(value!);
      _sugestionStreamController.add(results);
    };

    final timer = Timer.periodic( const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
