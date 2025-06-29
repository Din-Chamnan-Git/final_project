import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/const/themes/app_theme.dart';
import 'package:final_project/controllers/movie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(MovieController());
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
                                  return Stack(
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
                                                style: AppThemeData.montserrat(
                                                  20,
                                                  FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                movie.releaseDate,
                                                style: AppThemeData.montserrat(
                                                  16,
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index % 3;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              bool isActive = _currentIndex == index;

                              return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: isActive ? 16 : 8,
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
