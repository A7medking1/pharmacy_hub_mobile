import 'package:equatable/equatable.dart';

class AlternativeProductParams extends Equatable {
  final String categoryId;

  final String activeIngredientId;

  final String productId;

  final String page;

  const AlternativeProductParams({
    required this.categoryId,
    required this.activeIngredientId,
    required this.page,
    required this.productId,
  });

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "activeIngredientId": activeIngredientId,
        "productId": productId,
        "index": page,
      };

  @override
  List<Object> get props => [
        categoryId,
        activeIngredientId,
        page,
        productId,
      ];
}

class SimilarProductParams extends Equatable {
  final String categoryId;
  final String diseaseId;
  final String page;
  final String productId;


  const SimilarProductParams({
    required this.categoryId,
    required this.diseaseId,
    required this.page,
    required this.productId,
  });

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "diseaseId": diseaseId,
        "productId": productId,
        "index": page,
      };

  @override
  List<Object> get props => [
        categoryId,
        diseaseId,
        page,
        productId,
      ];
}
