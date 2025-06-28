import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/controllers/movie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<MovieController>();

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
              child: Obx(() {
                if (controller.nowPlayingList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CarouselSlider(
                  items:
                      controller.nowPlayingList.map((movie) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${movie.backDropImage}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                  options: CarouselOptions(autoPlay: true),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
