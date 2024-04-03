class ProductModel {
  final int id;
  final String name;
  final double price;
  final String pictureUrl;
  final int categoryId;
  final dynamic diseaseId;
  final dynamic activeIngredientId;
  final int quantity;
  final String category;
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
