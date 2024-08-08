import 'package:flutter/material.dart';
import 'package:movie_app_tmd_api/api/api%20model/movie.dart';
import 'package:movie_app_tmd_api/styles/colors.dart';


class SearchItem extends StatefulWidget {
  const SearchItem({super.key});

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  final Future<List<Movie>> _movie = Movie.dataMovie();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                ColorStyle.backgroundItemColor,
                ColorStyle.backgroundItemColor2,
              ]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Text("re"),
      ),
    );
  }
}
