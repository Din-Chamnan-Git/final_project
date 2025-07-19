import 'package:final_project/models/categoryModel.dart';
import 'package:final_project/models/movieDetail.dart';
import 'package:final_project/models/movieModel.dart';
import 'package:final_project/models/nowPlayingModel.dart';
import 'package:final_project/services/api_service.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  RxList<Nowplayingmodel> nowPlayingList = <Nowplayingmodel>[].obs;
  RxList<MovieModel> movieByCategory = <MovieModel>[].obs;

  final categoryList = <Categorymodel>[].obs;

  var movieDetail = Rxn<Moviedetail>();

  var isLoading = true.obs;
  var detailLoading = false.obs;

  final apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovies();
    categoryController();
  }

  void fetchNowPlayingMovies() async {
    try {
      isLoading.value = true;
      final movies = await apiService.fetchNowPlaying();
      nowPlayingList.assignAll(movies);
      print("Fetched ${movies.length} movies.");
    } catch (e) {
      print("Controller error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void categoryController() async {
    try {
      isLoading.value = true;
      final cateList = await apiService.fetchCategory();
      categoryList.assignAll(cateList);
      print("Fetched ${cateList.length} movies.");
    } catch (e) {
      print("Controller error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  var isSelectID = 0.obs;

  void selectCategory(int id) {
    isSelectID.value = id;

    if (id == 0) {
      fetchNowPlayingMovies();
    } else {
      final selected = categoryList.firstWhereOrNull((cat) => cat.id == id);
      if (selected != null) {
        fetchMovieByNameCategory(selected.name);
      }
    }
  }

  List<String> getGenreNames(List<int> genreIds) {
    return genreIds.map((id) {
      final match = categoryList.firstWhereOrNull((c) => c.id == id);
      return match?.name ?? "Unknown";
    }).toList();
  }

  Future<void> fetchMovieByNameCategory(String genName) async {
    try {
      movieByCategory.value = await apiService.fetchMovieByName(genName);
    } catch (e) {
      throw Exception("Errro ");
    }
  }

  Future<void> getDetail(int movieId)async {
    try {
      detailLoading.value = true;
      print("Requesting detail for ID: $movieId");

      final result = await apiService.fetchMovieDetail(movieId);

      if (result != null) {
        print("Result: ${result.title}");
        movieDetail.value = result;
      } else {
        Get.snackbar("Error", "Movie detail not found.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load movie detail: $e");
    } finally {
      detailLoading.value = false;
    }
  }
}
