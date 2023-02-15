import 'package:ecommerce/data/apis/apis-client.dart';
import 'package:ecommerce/utils/app-constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConst.recommendedProductUrl);
  }
}
//http://www.dbestech.com/api/product/list
//http://mvs.bslmeiyu.com/api/v1/products/popular
//http://mvs.bslmeiyu.com/api/v1/products/recommended
