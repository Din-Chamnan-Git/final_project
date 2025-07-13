class MovieModel {
  final int id;
  final String title;
  final String description;
  final double view;
  final String posterPath;
  final String backDrop;
  final double rate;
  final String releasedate;
  final List<int> category;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.view,
    required this.posterPath,
    required this.backDrop,
    required this.rate,
    required this.releasedate,
    required this.category,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      description: json['overview'] ?? 'No Description',
      view: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      backDrop: json['backdrop_path'] ?? '',
      rate: (json['vote_average'] ?? 0).toDouble(),
      releasedate: json['release_date'] ?? 'Unknown',
      category: json['genre_ids'] != null
          ? List<int>.from(json['genre_ids'])
          : [],
    );
  }
}
