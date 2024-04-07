import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String pictureUrl;
  @HiveField(5)
  final int categoryId;
  @HiveField(6)
  final dynamic diseaseId;
  @HiveField(7)
  final dynamic activeIngredientId;
  @HiveField(8)
  final int quantity;
  @HiveField(9)
  final String category;
  @HiveField(10)
  final List<String> pharmacies;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.pictureUrl,
    required this.categoryId,
    required this.diseaseId,
    required this.activeIngredientId,
    required this.quantity,
    required this.pharmacies,
    required this.category,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        pictureUrl: json["pictureUrl"],
        categoryId: json["categoryId"],
        diseaseId: json["diseaseId"],
        activeIngredientId: json["activeIngredientId"],
        quantity: json["quantity"],
        category: json["category"],
        pharmacies: List<String>.from(json["pharmacies"].map((x) => x)),
      );
}
