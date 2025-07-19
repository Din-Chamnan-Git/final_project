import 'package:final_project/models/movieModel.dart';
import 'package:final_project/services/api_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final ApiService service = ApiService();

  var searchList = <MovieModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchSearch(String query) async {
    if (query.trim().isEmpty) {
      searchList.clear();
      return;
    }

    isLoading.value = true;
    errorMessage.value = ''; // clear previous error

    try {
      final result = await service.fetchSearchByname(query);
      searchList.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
