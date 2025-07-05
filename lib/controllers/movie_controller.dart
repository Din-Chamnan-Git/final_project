import 'package:final_project/models/categoryModel.dart';
import 'package:final_project/models/nowPlayingModel.dart';
import 'package:final_project/services/api_service.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  final nowPlayingList = <Nowplayingmodel>[].obs;
  final categoryList = <Categorymodel>[].obs;

  var isLoading = true.obs;

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
    // If you want to refetch movies based on selected category:
    // fetchMoviesByCategory(id);
  }

  List<String> getGenreNames(List<int> genreIds) {
    return genreIds.map((id) {
      final match = categoryList.firstWhereOrNull((c) => c.id == id);
      return match?.name ?? "Unknown";
    }).toList();
  }
}
