// ignore_for_file: avoid_print, unused_field, prefer_final_fields

import 'package:ecommerce/data/repository/recommended_product_repo.dart';
import 'package:ecommerce/models/product_models.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("get Recommended //////////////");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoad = true;
      update();
    } else {
      print("Error Revvvvvvvvv");
    }
  }
}
