import 'package:flutter/material.dart';
import 'package:movie_app_tmd_api/api/api%20model/movie.dart';
import 'package:movie_app_tmd_api/home/home.dart';
import 'package:movie_app_tmd_api/poviders/rating_star.dart';
import 'package:provider/provider.dart';

import '../styles/colors.dart';


class MovieClicked extends StatefulWidget {
  final Movie movieClicked;
  const MovieClicked({super.key, required this.movieClicked});

  @override
  State<MovieClicked> createState() => _MovieClickedState();
}

class _MovieClickedState extends State<MovieClicked> {
  @override
  Widget build(BuildContext context) {
    final _movieStar = Provider.of<RatingStar>(context);
    return Stack(
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
          ) ,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(widget.movieClicked.title, style: const TextStyle(color: ColorStyle.whiteColor, fontSize: 20, overflow: TextOverflow.ellipsis),),
                  shadowColor: Colors.black,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const HomePage(),));
                    },
                      icon: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: const Center(child: Icon(Icons.arrow_back, color: ColorStyle.whiteColor,)
                          )
                      )
                  ),
                  expandedHeight: 300,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Stack(
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
                        ) ,
                        child: FlexibleSpaceBar(
                          titlePadding: const EdgeInsets.only(left: 50, bottom: 15),
                          // collapseMode: CollapseMode.parallax,
                          expandedTitleScale: 1.5,
                          centerTitle: false,
                          background: Stack(
                            children: [
                                  Container(
                                      color: Colors.red,
                                      width: double.infinity,
                                  child: Image.network('https://image.tmdb.org/t/p/w500${widget.movieClicked.thumbnail}', fit: BoxFit.cover,)),
                              Container(
                                height: 400,
                                width: double.infinity,
                                color: ColorStyle.blurColor,
                              ),
                              Positioned(
                                bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${widget.movieClicked.rating}', style: const TextStyle(color: ColorStyle.whiteColor),),
                                        const Text('API by TMDB', style: TextStyle(color: ColorStyle.whiteColor),),
                                      ],
                                    ),
                                  ),
                              )
                                ],
                          ),

                        ),
                      ),

                    ],
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('Overview', style: TextStyle(color: ColorStyle.whiteColor, fontSize: 30, fontWeight: FontWeight.bold)),
                              Text(widget.movieClicked.overview, style: const TextStyle(color: ColorStyle.whiteColor)),
                              const SizedBox(height: 30),
                              const Text('API Legal Notice', style: TextStyle(color: ColorStyle.whiteColor, fontSize: 30, fontWeight: FontWeight.bold)),
                              const Divider(),
                              Text('We do not claim ownership of '
                                  'any of the images or data in the API. '
                                  'We comply with the Digital Millennium Copyright Act (DMCA) and expeditiously remove infringing content when properly notified. Any data and/or images you upload you expressly grant us a license to use. You are prohibited from using the images and/or data in connection with libelous, defamatory, obscene, pornographic, abusive or otherwise offensive content.', style: const TextStyle(color: ColorStyle.whiteColor)),
                              //Batas suci
                              const SizedBox(
                                width: double.infinity,
                                height: 1000,
                              )

                            ],
                          ),
                        );
                      },
                    ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
