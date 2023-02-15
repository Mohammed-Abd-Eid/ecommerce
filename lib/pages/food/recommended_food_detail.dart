// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, must_be_immutable

import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/populer_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/routes/routes_helper.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/utils/dimensions.dart';
import 'package:ecommerce/widgets/app_icon.dart';
import 'package:ecommerce/widgets/big_text.dart';
import 'package:ecommerce/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app-constants.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var products =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(products, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.initial);
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutesHelper.getCartPage(pageId));
                          },
                          child: AppIcon(icon: Icons.shopping_cart_outlined)),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                                size: 20,
                              ),
                            )
                          : Container(),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 6,
                              top: 3,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20)),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                child: Text(
                  products.name,
                  style: TextStyle(
                      fontSize: Dimensions.font26, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConst.appBaseUrl + AppConst.upload + products.img,
                  width: double.maxFinite,
                  fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width15,
                      right: Dimensions.width15,
                      bottom: Dimensions.height30),
                  child: ExpandableText(text: products.description),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20 * 2.5,
                  vertical: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconColor: Colors.white,
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.icon24,
                      ),
                    ),
                    BigText(
                      text: "\$${products.price}" +
                          " X " +
                          " ${controller.inCartItems} ",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        iconColor: Colors.white,
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.icon24,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height30,
                  bottom: Dimensions.height20,
                ),
                margin: EdgeInsets.only(top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius30),
                      topRight: Radius.circular(Dimensions.radius30)),
                  color: Colors.grey[200],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal: Dimensions.width10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: AppIcon(
                          icon: Icons.favorite,
                          iconColor: AppColors.mainColor,
                          backgroundColor: Colors.white,
                          iconSize: Dimensions.icon24,
                        )),
                    GestureDetector(
                      onTap: () {
                        controller.addItems(products);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height20,
                            horizontal: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                            text: "\$ ${products.price}  | Add to cart",
                            color: Colors.white,
                            size: Dimensions.font20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
