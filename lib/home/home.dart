import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:movie_app_tmd_api/api/api%20model/movie.dart';
import 'package:movie_app_tmd_api/components/icons/icon_componnent.dart';
import 'package:movie_app_tmd_api/pages/home_item.dart';
import 'package:movie_app_tmd_api/pages/save_item.dart';
import 'package:movie_app_tmd_api/pages/search_item.dart';
import 'package:movie_app_tmd_api/styles/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  int?selected;
  List<Widget> pages = const [
    HomeItem(),
    SearchItem(),
    SaveItem(),
  ];
  int botNavIndex = 0;

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final Future<List<Movie>> movie = Movie.dataMovie();
    final List<IconComponent> iconsComp = IconComponent.dataIcon();
    super.build(context);
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    ColorStyle.backgroundItemColor,
                    ColorStyle.backgroundItemColor2,
                  ],
              ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(1, 2)
              ),
            ],
          ) ,

          child: Stack(
            children :[ Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  const SizedBox(height: 20),
                  //AppBar-------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          height: 100,
                          width: 85,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = 1;
                              });
                            },
                              child: const Icon(Icons.menu, color: ColorStyle.whiteColor, size: 35,))),
                     Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: botNavIndex == 0 ?
                        const Text("Your Movie", style: TextStyle(color: ColorStyle.whiteColor, fontSize: 27, fontWeight: FontWeight.bold))
                            : botNavIndex == 1 ?
                        const Text("Search", style: TextStyle(color: ColorStyle.whiteColor, fontSize: 27, fontWeight: FontWeight.bold))
                            :
                        const Text("Save", style: TextStyle(color: ColorStyle.whiteColor, fontSize: 27, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Expanded(child: pages[botNavIndex]),

                ],
              )
            ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: ColorStyle.backgroundItemColor2,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 8,
                            offset: const Offset(1, 1)
                        ),]
                  ),
                  child: ClipRRect(
                    child: BottomNavigationBar(
                      currentIndex: botNavIndex,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      selectedItemColor: ColorStyle.whiteColor,
                      unselectedItemColor: ColorStyle.whiteColor,
                      items: [
                        BottomNavigationBarItem(
                            icon: Column(

                          children: [
                            if (botNavIndex == 0)
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              height: 4.5,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorStyle.whiteColor,

                              ),
                            ),
                            const Icon(Iconsax.home_1_copy),
                          ],
                        ), label: "Home"),
                        BottomNavigationBarItem(
                            icon: Column(
                          children: [
                            if (botNavIndex == 1)
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                height: 4.5,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorStyle.whiteColor,

                                ),
                              ),
                            const Icon(Iconsax.search_normal_copy),
                          ],
                        ), label: "Search"),
                        BottomNavigationBarItem(
                            icon: Column(
                          children: [
                            if (botNavIndex == 2)
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                height: 4.5,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorStyle.whiteColor,

                                ),
                              ),
                            const Icon(Iconsax.save_2_copy),
                          ],
                        ), label: "Save"),

                      ],
                      onTap: (value) {
                        setState(() {
                          botNavIndex = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (selected == 1)
          GestureDetector(
            onTap: () {
              setState(() {
                selected = null;
              });
            },
            child: Align(
              alignment: Alignment.bottomLeft,
              child: BackdropFilter(
                filter: ColorStyle.blurFilter,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.blueAccent.withOpacity(0.02),
                ),
              ),
            ),
          ),
        AnimatedPositioned(
          curve: Curves.linear,
          bottom: 0,
          left: selected != 1 ? -500 : 0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            height: 900,
            width: 350 ,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    ColorStyle.backgroundItemColor2,
                    ColorStyle.backgroundItemColor4,
                  ],
                ),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(35)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: const Offset(1, 1)
                  ),]
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(35)),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    FutureBuilder(
                      future: movie,
                      builder: (context, dynamic snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                              child: Image.asset('assets/images/loading_screen.gif', width: 60,));
                        } else if (snapshot.hasData) {
                          return Stack(
                            children: [
                              CarouselSlider.builder(
                                itemCount: snapshot.data.length,
                                options: CarouselOptions(
                                  height: 300,
                                  autoPlay: true,
                                  viewportFraction: 1,
                                  autoPlayInterval: const Duration(seconds: 1),
                                ),
                                itemBuilder: (context, index, realIndex) {
                                  return Container(
                                    width: double.infinity,
                                    color: Colors.amber,
                                    child: Image.network( 'https://image.tmdb.org/t/p/w500${snapshot.data[index].thumbnail}', fit: BoxFit.cover,),
                                  );
                                },
                              ),
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                height: 300,
                                width: double.infinity,
                              ),
                            ],
                          );
                        } else {
                          return const Center(child: Text("No Data"));
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          for (int i = 0; i < iconsComp.length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: Color(0xFF5A708C),
                                ),
                                child: Row(
                                  children: [
                                    Icon(iconsComp[i].sosmedIcon.icon, size: 30, color: ColorStyle.whiteColor,),
                                    const SizedBox(width: 15),
                                    Text(iconsComp[i].sosmedName, style: const TextStyle(color: ColorStyle.whiteColor,
                                      fontSize: 18,
                                    ),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 3),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
