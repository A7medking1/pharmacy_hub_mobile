import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';

enum ReqState { loading, empty, error, success }

enum ProductType { medicine, vitamins, equipment, cares }

List<ProductModel> getCurrentList(ProductType type,final vitamins , final equipment , final cares ) {
  switch (type) {
    case ProductType.vitamins:
      return vitamins;
    case ProductType.equipment:
      return equipment;
    case ProductType.cares:
      return cares;
    default:
      return [];
  }
}

extension ProductTypeExtension on ProductType {
  // Map an index to a ProductType
  static ProductType fromIndex(int index) {
    switch (index) {
      case 0:
        return ProductType.medicine;
      case 1:
        return ProductType.vitamins;
      case 2:
        return ProductType.equipment;
      case 3:
        return ProductType.cares;
      default:
        throw RangeError('Invalid index for ProductType');
    }
  }
}
