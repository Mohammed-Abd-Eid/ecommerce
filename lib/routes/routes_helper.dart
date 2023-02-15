// ignore_for_file: unnecessary_string_interpolations

import 'package:ecommerce/pages/cart/cart_page.dart';
import 'package:ecommerce/pages/food/popular_food_detail.dart';
import 'package:ecommerce/pages/food/recommended_food_detail.dart';
import 'package:ecommerce/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RoutesHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static String getInitial() => "$initial";

  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";

  static String getRecommendedFood(int pageId) =>
      "$recommendedFood?pageId=$pageId";
  static String getCartPage(int pageId) => "$cartPage?pageId=$pageId";

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          return const MainFoodPage();
        },
        transition: Transition.fadeIn),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters["pageId"];
        return PopularFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.downToUp,
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          return RecommendedFoodDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          var pageId = Get.parameters["pageId"];
          return CartPage(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
  ];
}
