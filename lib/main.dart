import 'package:flutter/material.dart';
import 'package:movie_app_tmd_api/home/home.dart';
import 'package:movie_app_tmd_api/poviders/isWatchLater.dart';
import 'package:movie_app_tmd_api/poviders/rating_star.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RatingStar(),),
        ChangeNotifierProvider(create: (_) => WatchLater(),),
    ],
    child:const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
