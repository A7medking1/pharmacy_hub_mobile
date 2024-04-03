class CategoryModel {
  final int id;
  final String name;
  final String pictureUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.pictureUrl,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    pictureUrl: json["pictureUrl"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "pictureUrl": pictureUrl,
  };
}