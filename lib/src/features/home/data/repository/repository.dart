import 'package:dio/dio.dart';
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
        await _apiConsumer.get('${ApiConstant.medicine}&page=$page');

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getVitamins({int page = 1}) async {
    final Response response =
        await _apiConsumer.get('${ApiConstant.vitamins}&page=$page');

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getEquipments({int page = 1}) async {
    final Response response =
        await _apiConsumer.get('${ApiConstant.equipments}&page=$page');

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }

  Future<List<ProductModel>> getCares({int page = 1}) async {
    final Response response =
        await _apiConsumer.get('${ApiConstant.cares}&page=$page');

    return List<ProductModel>.from(
      (response.data['data']).map(
        (e) => ProductModel.fromMap(e),
      ),
    );
  }
}
