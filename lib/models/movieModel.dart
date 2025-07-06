class Moviemodel {
  final int id;
  final String title;
  final String description;
  final double view;
  final String posterPath;
  final String backDrop;
  final double rate;
  final String releasedate;
  final List<int> category;

  Moviemodel({
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

  factory Moviemodel.fromJson(Map<String, dynamic> json) {
    return Moviemodel(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      description: json['overview'] ?? 'No Description',
      view: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      backDrop: json['backdrop_path'] ?? '',
      rate: (json['vote_average'] ?? 0).toDouble(),
      releasedate: json['release_date'],
      category: List<int>.from(json['genre_ids']),
    );
  }
}
