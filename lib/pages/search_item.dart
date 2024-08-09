import 'package:flutter/material.dart';
import 'package:movie_app_tmd_api/poviders/search_provider.dart';
import 'package:movie_app_tmd_api/styles/colors.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({super.key});

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {

  @override
  void dispose() {
    // Membersihkan controller untuk menghindari kebocoran memori
    Provider.of<SearchFn>(context, listen: false).searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchFn>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            ColorStyle.backgroundItemColor,
            ColorStyle.backgroundItemColor2,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: ColorStyle.whiteColor),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: ColorStyle.whiteColor),
                        ),
                        controller: searchProvider.searchController,
                        onChanged: (value) {
                          searchProvider.searchMovieFn(value);
                        },
                        onSubmitted: (value) {
                          searchProvider.onSearchSubmitted();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Consumer<SearchFn>(
                builder: (context, searchProvider, child) {
                  if (!searchProvider.isSearchDone) {
                    return const Center(
                      child: Text("Search Your favorite Video", style: TextStyle(color: ColorStyle.whiteColor),),
                    );
                  }
                  if (searchProvider.filteredMovies.isEmpty) {
                    return const Center(
                      child: Text("No results found", style: TextStyle(color: ColorStyle.whiteColor)),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: searchProvider.filteredMovies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(searchProvider.filteredMovies[index].title),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
