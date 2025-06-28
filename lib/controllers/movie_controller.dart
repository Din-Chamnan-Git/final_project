import 'package:final_project/models/nowPlayingModel.dart';
import 'package:final_project/services/api_service.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  final nowPlayingList = <Nowplayingmodel>[].obs;

  ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingg();
  }

  Future<void> fetchNowPlayingg() async {
    nowPlayingList.value = await apiService.fetchNowPlaying();
  }
}
