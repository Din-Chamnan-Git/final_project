import 'dart:convert';
import 'package:final_project/models/nowPlayingModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api.themoviedb.org/3";
  String get apikey => dotenv.get("api_key");

  Future<List<Nowplayingmodel>> fetchNowPlaying() async {
    final url = Uri.parse('$baseUrl/movie/now_playing?api_key=$apikey');

    try {
      final response = await http.get(url);
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['results'];
        return (data as List)
            .map((json) => Nowplayingmodel.fromjson(json))
            .toList();
      } else {
        throw Exception(
          "Failed to fetch now playing movies. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("API Error: $e");
      return [];
    }
  }
}
