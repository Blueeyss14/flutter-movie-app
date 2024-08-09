import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
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
  List<Widget> pages = [
    HomeItem(),
    SearchItem(),
    SaveItem(),
  ];
  int botNavIndex = 0;

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
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
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      height: 100,
                      width: 85,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Icon(Icons.menu, color: ColorStyle.whiteColor, size: 35,)),
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
                  border: Border.all(
                    color: ColorStyle.whiteColor,
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        ColorStyle.backgroundItemColor,
                        ColorStyle.backgroundItemColor2,
                      ]
                  )
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
