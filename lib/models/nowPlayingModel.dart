class Nowplayingmodel {
  final int id;
  final String title;
  final String backDropImage;
  final String releaseDate;

  Nowplayingmodel({
    required this.id,
    required this.title,
    required this.backDropImage,
    required this.releaseDate,
  });

  factory Nowplayingmodel.fromjson(Map<String, dynamic> json) {
    return Nowplayingmodel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      backDropImage: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
    );
  }
}
