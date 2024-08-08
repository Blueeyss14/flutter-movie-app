import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_tmd_api/api/api%20model/movie.dart';
import 'package:movie_app_tmd_api/poviders/rating_star.dart';
import 'package:movie_app_tmd_api/routes/item_clicked_route.dart';
import 'package:movie_app_tmd_api/styles/colors.dart';
import 'package:provider/provider.dart';

import '../poviders/isWatchLater.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({super.key});


  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> with AutomaticKeepAliveClientMixin {
  static int? selectedIndex;

  final Future<List<Movie>> _movie = Movie.dataMovie();
  @override
  void initState() {
    super.initState();
    Provider.of<RatingStar>(context, listen: false).fetchMovies();

    final watchLaterProvider = Provider.of<WatchLater>(context, listen: false);
    _movie.then((movies) {
      watchLaterProvider.initializeList(movies.length);
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ratingStars = Provider.of<RatingStar>(context);
    final watchLaterProvider = Provider.of<WatchLater>(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = null;
        });
      },
      child: Stack(
        children: [
          Container(
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
            backgroundColor: (selectedIndex == null) ?  Colors.transparent : ColorStyle.blurColor ,
            body: FutureBuilder(
              future: _movie,
              builder: (context, dynamic snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                    ),
                  );
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CarouselSlider.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.network( 'https://image.tmdb.org/t/p/w500${snapshot.data[index].thumbnail}', fit: BoxFit.cover,),
                                );
                              },
                              options: CarouselOptions(
                                height: 310,
                                autoPlay: true,
                                  viewportFraction : 1,
                              )),
                            //AppBar---------Blur
                            Align(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = null;

                                  });
                                },
                                child: Container(
                                  height: 310,
                                  width: double.infinity,
                                  color: ColorStyle.blurColor,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                                child: Column(
                                  children: [
                                    SizedBox(width: 20),
                                    Text("Watch Now", style: TextStyle(color:ColorStyle.whiteColor, fontSize: 34, fontWeight: FontWeight.bold),),
                                  ],),
                              ),
                            ),
                            if (selectedIndex != null)
                              Align(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = null;

                                    });
                                  },
                                  child: Container(
                                    height: 310,
                                    width: double.infinity,
                                    color: ColorStyle.blurColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap : () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieClicked(
                                          movieClicked: snapshot.data[index]),
                                      )
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color : ColorStyle.itemColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Stack(
                                            children: [
                                              Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 150,
                                                  width: 100,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: Image.network(
                                                      'https://image.tmdb.org/t/p/w500${snapshot.data[index].thumbnail}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Container(
                                                  height: 148,
                                                  width: 300,
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Title: ${snapshot.data[index].title}',
                                                        style: const TextStyle(color: ColorStyle.whiteColor),
                                                      ),
                                                      Text(
                                                        'Overview: ${snapshot.data[index].overview}',
                                                        style: const TextStyle(color: ColorStyle.whiteColor, overflow: TextOverflow.ellipsis),
                                                      ),
                                                      Text(
                                                        'Release: ${snapshot.data[index].release}',
                                                        style: const TextStyle(color: ColorStyle.whiteColor),
                                                      ),
                                                      Text(
                                                        'Rating: ${snapshot.data[index].rating}',
                                                        style: const TextStyle(color: ColorStyle.whiteColor),
                                                      ),
                                                      // star Icons
                                                      ratingStars.starWidgets[index],
                                                    ],
                                                  ),
                                                ),
                                                // const SizedBox(width: 5),
                                              ],),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  const SizedBox(width: 5),

                                                  InkWell(
                                                    splashColor: Colors.transparent,
                                                    onTap: () {
                                                      setState(() {
                                                        if (selectedIndex == index) {
                                                          selectedIndex = null;
                                                        } else {
                                                          selectedIndex = index;
                                                        }

                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.more_vert,
                                                      color: ColorStyle.whiteColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]
                                          ),
                                        ),
                                          //-----------------------------------------------------------------------
                                      ),
                                        if (selectedIndex != null)
                                          Align(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = null;
                                                });
                                              },
                                              child: Container(
                                                height: 170,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: ColorStyle.blurItemColor,

                                                ),
                                              ),
                                            ),
                                          ),
                                      ]
                                    ),
                                  ),

                                  if (selectedIndex == index)
                                    Positioned(
                                      right: 20,
                                      top: 40,
                                      child: Container(
                                        height: 70,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                          ColorStyle.backgroundItemColor,
                                          ColorStyle.backgroundItemColor2,
                                          ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: const Offset(1, 2)
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    watchLaterProvider.toggleWatchLater(index);
                                                  });

                                                } ,
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                                          child:  !watchLaterProvider.isWatchLater[index] ? const Text("Save", style: TextStyle(color: ColorStyle.whiteColor,))
                                                              : const Text("Saved", style: TextStyle(color: ColorStyle.whiteColor,)),
                                                        ),
                                                        const Icon(FluentIcons.arrow_download_20_filled, size: 20, color: ColorStyle.whiteColor,)
                                                      ],
                                                    )),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap : () {
                                                  setState(() {
                                                    print("Share");
                                                  });
                                                },
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                    ),
                                                    child: const Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                                          child: Text("Share", style: TextStyle(color: ColorStyle.whiteColor,)),
                                                        ),
                                                        Icon(FluentIcons.arrow_forward_24_regular, color: ColorStyle.whiteColor,)
                                                      ],

                                                    )),
                                              ),
                                            ),
                                          ],

                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text("No data"));
                }
              },
            ),
                    ),
          ),

        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


}
