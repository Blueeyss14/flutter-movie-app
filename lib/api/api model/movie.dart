import 'dart:convert';

import 'package:movie_app_tmd_api/api/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_tmd_api/pages/home_item.dart';

class Movie {
  String title, thumbnail, overview, release;
  double rating;
  int moreVert;

  Movie({
    required this.title, required this.thumbnail, required this.overview, required this.release, required this.rating, required this.moreVert,
  });

  static Future<List<Movie>> dataMovie() async {
    Uri url = Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=${ApiKey.apiKey}&page=${HomeItem.page}');
    var responseAPI = await http.get(url);
    var data = (jsonDecode(responseAPI.body)) ['results'] as List;

    return data.map((data) => Movie(
        title: data['title'],
        thumbnail: data['poster_path'],
        overview: data['overview'],
        release: data['release_date'],
        rating: data['vote_average'],
        moreVert: 0,
    )).toList();

  }
}
