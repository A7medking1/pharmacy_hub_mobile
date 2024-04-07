import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';

class FavoriteItem extends ProductModel {
  FavoriteItem({
    required super.id,
    required super.name,
    required super.price,
    required super.pictureUrl,
    required super.categoryId,
    required super.diseaseId,
    required super.activeIngredientId,
    required super.quantity,
    required super.pharmacies,
    required super.category,
  });

  factory FavoriteItem.fromEntity(ProductModel model) {
    return FavoriteItem(
      categoryId: model.categoryId,
      pictureUrl: model.pictureUrl,
      id: model.id,
      name: model.name,
      price: model.price,
      diseaseId: model.diseaseId,
      activeIngredientId: model.activeIngredientId,
      quantity: model.quantity,
      pharmacies: model.pharmacies,
      category: model.category,
    );
  }

  @override
  String toString() {
    return '${super.id}, ${super.name}, ${super.pictureUrl}, ${super.price}, ${super.pharmacies}';
  }
}
