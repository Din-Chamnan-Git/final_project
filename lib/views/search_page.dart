import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart' as my; // ✅ alias

class SearchPage extends StatelessWidget {
  final my.SearchController controller = Get.put(
    my.SearchController(),
  ); // ✅ use alias

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Movies")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search movies...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => controller.fetchSearch(value),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              } else if (controller.searchList.isEmpty) {
                return Center(child: Text("No results"));
              } else {
                return ListView.builder(
                  itemCount: controller.searchList.length,
                  itemBuilder: (context, index) {
                    final movie = controller.searchList[index];
                    return ListTile(
                      title: Text(movie.title ?? "No Title"),
                      subtitle: Text(
                        movie.description ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
