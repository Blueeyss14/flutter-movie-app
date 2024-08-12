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
                 color: ColorStyle.backgroundItemColor3
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.05),
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
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                    children: [
                                      SizedBox(
                                          height: 70,
                                          width: 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                              child: Image.network( 'https://image.tmdb.org/t/p/w500${searchProvider.filteredMovies[index].thumbnail}', fit: BoxFit.cover,)),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(searchProvider.filteredMovies[index].title, style: const TextStyle(color: ColorStyle.whiteColor)),
                                          Text('${searchProvider.filteredMovies[index].rating}', style: const TextStyle(color: ColorStyle.whiteColor)),
                                        ],
                                      ),
                                    ],
                                ),
                              ),
                            )
                          ],
                        )
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
