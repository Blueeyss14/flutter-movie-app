
import 'package:flutter/material.dart';

import '../api/api model/movie_search.dart';


class SearchFn with ChangeNotifier {
  final Future<List<SearchMovie>> _searchMovie = SearchMovie.dataMovie();
  List<SearchMovie> _allMovies = [];
  List<SearchMovie> _filteredMovies = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchDone = false;

  SearchFn() {
    _initializeMovies();
  }

  Future<void> _initializeMovies() async {
    _allMovies = await _searchMovie;
    _filteredMovies = [];
    notifyListeners();
  }

  List<SearchMovie> get filteredMovies => _filteredMovies;
  TextEditingController get searchController => _searchController;

  void searchMovieFn(String search) {
    _filteredMovies = _allMovies
        .where((movie) => movie.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
    _isSearchDone = search.isNotEmpty;
    notifyListeners();
  }

  void onSearchSubmitted() {
    _isSearchDone = true;
    notifyListeners();
  }

  bool get isSearchDone => _isSearchDone;
}