import 'package:final_project/models/nowPlayingModel.dart';
import 'package:final_project/services/api_service.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  final nowPlayingList = <Nowplayingmodel>[].obs;
  var isLoading = true.obs;

  final apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovies();
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
}
