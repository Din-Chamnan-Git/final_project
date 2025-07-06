import 'dart:convert';
import 'package:final_project/models/categoryModel.dart';
import 'package:final_project/models/movieModel.dart';
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

  Future<List<Categorymodel>> fetchCategory() async {
    final url = Uri.parse('$baseUrl/genre/movie/list?api_key=$apikey');

    try {
      final respone = await http.get(url);

      if (respone.statusCode == 200) {
        var data = jsonDecode(respone.body)['genres'];

        return (data as List)
            .map((json) => Categorymodel.fromJson(json))
            .toList();
      } else {
        throw Exception("Errro");
      }
    } catch (e) {
      throw Exception("Error loading categories: $e");
    }
  }

  Future<List<Moviemodel>> fetchMovieByName(String genreName) async {
    final allGenres = await fetchCategory();

    // 2. Find the genre that matches the name (case-insensitive)
    final genre = allGenres.firstWhere(
      (g) => g.name.toLowerCase() == genreName.toLowerCase(),
      orElse: () => throw Exception('Genre not found'),
    );

    final url = Uri.parse(
      "$baseUrl/discover/movie?api_key=$apikey&with_genres=${genre.id}",
    );

    var respone = await http.get(url);

    if (respone.statusCode == 200) {
      var data = jsonDecode(respone.body)['results'];

      return (data as List).map((e) => Moviemodel.fromJson(e)).toList();
    } else {
      throw Exception("Error Load Data ");
    }
  }
}
