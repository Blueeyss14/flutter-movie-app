import 'package:flutter/material.dart';
import 'package:movie_app_tmd_api/api/api%20model/movie.dart';
import 'package:movie_app_tmd_api/poviders/isWatchLater.dart';
import 'package:movie_app_tmd_api/poviders/rating_star.dart';
import 'package:movie_app_tmd_api/routes/item_clicked_route.dart';
import 'package:movie_app_tmd_api/styles/colors.dart';
import 'package:provider/provider.dart';

class SaveItem extends StatefulWidget {
  const SaveItem({super.key});

  @override
  State<SaveItem> createState() => _SaveItemState();
}

class _SaveItemState extends State<SaveItem> {
  final Future<List<Movie>> _movie = Movie.dataMovie();
  @override
  Widget build(BuildContext context) {
    final save = Provider.of<WatchLater>(context);
    bool noData = save.isWatchLater.every((element) => !element);
    final ratingStars = Provider.of<RatingStar>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: noData ? const Center(child: Text("No Video Saved", style: TextStyle(color: ColorStyle.whiteColor),),)
          : FutureBuilder<List<Movie>>(
        future: _movie,
        builder: (context, dynamic snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Image.asset('assets/images/loading_screen.gif', width: 80,)
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                if (save.isWatchLater[index]) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap : () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieClicked(
                                  movieClicked: snapshot.data[index]),
                              )
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                              child: Image.network('https://image.tmdb.org/t/p/w500${snapshot.data[index].thumbnail}'),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data[index].title, style: const TextStyle(color: ColorStyle.whiteColor),),
                                            Text('${snapshot.data[index].rating}', style: const TextStyle(color: ColorStyle.whiteColor),),
                                            ratingStars.starWidgets[index],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                        save.isWatchLater[index] = false;
                                    });
                                  },
                                    child: const Icon(Icons.delete, color: ColorStyle.whiteColor,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          } else {
            return const Text("No Data");
          }
        },
      ),
    );
  }
}
