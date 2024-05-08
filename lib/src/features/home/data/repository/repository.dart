import 'package:dio/dio.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/features/home/data/models/category_model.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';
import 'package:pharmacy_hub/src/features/home/data/models/request_params.dart';

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
        await _apiConsumer.get(ApiConstant.product, queryParameters: {
      'index': page,
      'categoryId': '1',
    });

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getVitamins({int page = 1}) async {
    final Response response =
        await _apiConsumer.get(ApiConstant.product, queryParameters: {
      'index': page,
      'categoryId': '2',
    });

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getEquipments({int page = 1}) async {
    final Response response =
        await _apiConsumer.get(ApiConstant.product, queryParameters: {
      'index': page,
      'categoryId': '3',
    });
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getCares({int page = 1}) async {
    final Response response =
        await _apiConsumer.get(ApiConstant.product, queryParameters: {
      'index': page,
      'categoryId': '4',
    });
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getAlternativeMedicine(
      AlternativeProductParams params) async {
    final Response response = await _apiConsumer.get(
      ApiConstant.product,
      queryParameters: params.toJson(),
    );
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getSimilarMedicine(
      SimilarProductParams params) async {
    final Response response = await _apiConsumer.get(
      ApiConstant.product,
      queryParameters: params.toJson(),
    );
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getMoreProducts({
    required String categoryId,
    required String page,
  }) async {
    final Response response =
        await _apiConsumer.get(ApiConstant.product, queryParameters: {
      'index': page,
      'categoryId': categoryId,
    });
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> search(
      {required String page, required String text}) async {
    final Response response =
        await _apiConsumer.get(ApiConstant.product, queryParameters: {
      'search': text,
      'index': page,
      'pagesize': '10',
    });
    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }
}
