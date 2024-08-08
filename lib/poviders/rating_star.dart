import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_tmd_api/api/api%20model/movie.dart';

class RatingStar with ChangeNotifier {
  final Icon starIconFilled = const Icon(FluentIcons.star_20_filled);
  final Icon starIconRegular = const Icon(FluentIcons.star_20_regular);
  final Color starIconColor = Colors.yellow;
  final double starIconSize = 16;

  final Future<List<Movie>> _movieFuture = Movie.dataMovie();
  Future<List<Movie>> get movie => _movieFuture;

  List<Widget> _starWidgets = [];
  List<Widget> get starWidgets => _starWidgets;

  Future<void> fetchMovies() async {
    List<Movie> movies = await _movieFuture;
    _starWidgets = movies.map((movie) {
      if (movie.rating >= 9) {
        return Row(
          children: [
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
          ],
        );
      } else if ((movie.rating >= 7.5) && (movie.rating < 9)) {
        return Row(
          children: [
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
          ],
        );
      } else if ((movie.rating >= 5) && (movie.rating < 7.5)) {
        return Row(
          children: [
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
          ],
        );
      } else if ((movie.rating >= 3) && (movie.rating < 5)) {
        return Row(
          children: [
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
          ],
        );
      } else if ((movie.rating >= 1) && (movie.rating < 3)) {
        return Row(
          children: [
            Icon(starIconFilled.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
          ],
        );
      } else {
        return Row(
          children: [
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
            Icon(starIconRegular.icon, color: starIconColor, size: starIconSize),
          ],
        );
      }
    }).toList();
    notifyListeners();
  }
}
