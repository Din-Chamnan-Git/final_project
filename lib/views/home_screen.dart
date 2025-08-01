import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/const/themes/app_theme.dart';
import 'package:final_project/controllers/movie_controller.dart';
import 'package:final_project/views/detail_movie.dart';
import 'package:final_project/widgets/CustomCategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<MovieController>();
  // If not already injected
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Smit",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text("Let’s stream your favorite movie"),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 1,
                    bottom: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),

                      Expanded(
                        child: TextField(
                          style: TextStyle(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: " Find Here ",
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 18,
                        color: AppBarTheme.of(context).backgroundColor,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.clear_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.nowPlayingList.isEmpty) {
                        return const Center(child: Text("No movies found"));
                      }
                      return Column(
                        children: [
                          CarouselSlider(
                            items:
                                controller.nowPlayingList.map((movie) {
                                  if (movie == null) {
                                    // Return some empty widget or placeholder if movie is null
                                    return const SizedBox.shrink();
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => DetailMovie(moviID: movie.id),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "https://image.tmdb.org/t/p/w500${movie.backDropImage}",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              bottom: 20,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  movie.title,
                                                  style:
                                                      AppThemeData.montserrat(
                                                        20,
                                                        FontWeight.bold,
                                                      ),
                                                ),
                                                Text(
                                                  movie.releaseDate ??
                                                      'Unknown', // ✅ FIX HERE
                                                  style:
                                                      AppThemeData.montserrat(
                                                        16,
                                                        FontWeight.w500,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index % 4;
                                });
                              },
                            ),
                          ),

                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              bool isActive = _currentIndex == index;

                              return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: isActive ? 20 : 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isActive
                                          ? AppThemeData.primaryBlueAccent
                                          : AppThemeData.primarySoft,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                            child: Row(
                              children: [
                                Text(
                                  "Category",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            child: Column(
                              children: [
                                Obx(() {
                                  final list = controller.categoryList;
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CustomCategory(
                                          name: "All",
                                          isSelect:
                                              controller.isSelectID.value == 0,
                                          action:
                                              () =>
                                                  controller.selectCategory(0),
                                        ),
                                        ...list.map(
                                          (e) => CustomCategory(
                                            name: e.name,
                                            isSelect:
                                                controller.isSelectID.value ==
                                                e.id,
                                            action:
                                                () => controller.selectCategory(
                                                  e.id,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                SizedBox(height: 10),
                                Obx(() {
                                  if (controller.isSelectID.value == 0) {
                                    final movies = controller.nowPlayingList;

                                    if (movies.isEmpty) {
                                      return const Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          "No movies in this category.",
                                        ),
                                      );
                                    }

                                    return SizedBox(
                                      height: 270,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Row(
                                          children:
                                              movies.map((movie) {
                                                return Container(
                                                  width: 160,
                                                  margin: const EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  child: Card(
                                                    elevation: 3,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius.vertical(
                                                                top:
                                                                    Radius.circular(
                                                                      10,
                                                                    ),
                                                              ),
                                                          child: Image.network(
                                                            "https://image.tmdb.org/t/p/w200${movie.backDropImage}",
                                                            height: 200,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (
                                                                  context,
                                                                  error,
                                                                  stackTrace,
                                                                ) => const Icon(
                                                                  Icons
                                                                      .broken_image,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                8,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                movie.title,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                "Release: ${movie.releaseDate ?? 'Unknown'}",
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      Colors
                                                                          .grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                    );
                                  } else {
                                    final movies = controller.movieByCategory;

                                    if (movies.isEmpty) {
                                      return const Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          "No movies in this category.",
                                        ),
                                      );
                                    }

                                    return SizedBox(
                                      height: 270,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Row(
                                          children:
                                              movies.map((movie) {
                                                return Container(
                                                  width: 160,
                                                  margin: const EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  child: Card(
                                                    elevation: 3,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius.vertical(
                                                                top:
                                                                    Radius.circular(
                                                                      10,
                                                                    ),
                                                              ),
                                                          child: Image.network(
                                                            "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                                                            height: 200,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (
                                                                  context,
                                                                  error,
                                                                  stackTrace,
                                                                ) => const Icon(
                                                                  Icons
                                                                      .broken_image,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                8,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                movie.title,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                "Release: ${movie.releasedate ?? 'Unknown'}",
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      Colors
                                                                          .grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}
