import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/populer_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/data/apis/apis-client.dart';
import 'package:ecommerce/data/repository/cart_repo.dart';
import 'package:ecommerce/data/repository/popular_product_repo.dart';
import 'package:ecommerce/data/repository/recommended_product_repo.dart';
import 'package:ecommerce/utils/app-constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //api Client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConst.appBaseUrl));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());
  //Controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));

  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
//http://www.dbestech.com/api/product/list
//http://mvs.bslmeiyu.com/api/v1/products/popular
