import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/features/home/data/models/category_model.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';

class HomeRepository {
  final ApiConsumer _apiConsumer;

  HomeRepository(this._apiConsumer);

  Future<List<CategoryModel>> getCategories() async {
    final Response response = await _apiConsumer.get(ApiConstant.categories);

    return List<CategoryModel>.from(
      (response.data).map(
        (e) => CategoryModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getMedicine({int page = 1}) async {
    final Response response =
        await _apiConsumer.get('${ApiConstant.medicine}&index=$page');

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getVitamins({int page = 1}) async {
    final Response response =
        await _apiConsumer.get('${ApiConstant.vitamins}&index=$page');

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getEquipments({int page = 1}) async {
    final Response response =
        await _apiConsumer.get('${ApiConstant.equipments}&index=$page');

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getCares({int page = 1}) async {
    final Response response =
        await _apiConsumer.get('${ApiConstant.cares}&index=$page');

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getAlternativeMedicine(
      AlternativeProductParams params) async {
    final Response response =
        await _apiConsumer.get(ApiConstant.medicineAlternative(params: params));
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getSimilarMedicine(
      SimilarProductParams params) async {
    final Response response =
        await _apiConsumer.get(ApiConstant.medicineSimilar(params: params));
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getMoreProducts(
      {required String categoryId, required String page}) async {
    final Response response = await _apiConsumer
        .get('${ApiConstant.product}?categoryId=$categoryId&index=$page');
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> searchFor(
      {required String page, required String text}) async {
    final Response response = await _apiConsumer
        .get('${ApiConstant.product}?&index=$page&pagesize=10&search=$text');
    return List<ProductModel>.from(
      (response.data['data']).map(
            (e) => ProductModel.fromMap(e),
      ),
    );
  }
}
/*print(
'${ApiConstant.baseUrl}${ApiConstant.product}?categoryId=${params.categoryId}');*/

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

  @override
  List<Object> get props => [categoryId, activeIngredientId, page, productId];
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

  @override
  List<Object> get props => [categoryId, diseaseId, page, productId];
}
