import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';

// DetailMovie.dart

class DetailMovie extends StatefulWidget {
  final int moviID;
  const DetailMovie({super.key, required this.moviID});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  final controller = Get.find<MovieController>();

  @override
  void initState() {
    super.initState();

    // 👇 Always safe here — not inside build()
    controller.getDetail(widget.moviID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie Detail")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final movie = controller.movieDetail.value;
        if (movie == null) {
          return const Center(child: Text("Movie not found"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  movie.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Text("⭐ ${movie.voteAverage} | ⏱ ${movie.runtime} min"),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(movie.overview),
              ),
            ],
          ),
        );
      }),
    );
  }
}
