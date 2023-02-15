import 'package:ecommerce/data/apis/apis-client.dart';
import 'package:ecommerce/utils/app-constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConst.popularProductUrl);
  }
}
//http://www.dbestech.com/api/product/list
//http://mvs.bslmeiyu.com/api/v1/products/popular
//http://mvs.bslmeiyu.com/api/v1/products/recommended
