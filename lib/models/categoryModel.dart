class Categorymodel {
  final int id;
  final String name;

  Categorymodel({required this.id, required this.name});

  factory Categorymodel.fromJson(Map<String, dynamic> json) {
    return Categorymodel(id: json['id'], name: json['name']);
  }
}
