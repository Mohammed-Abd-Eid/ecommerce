// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:ecommerce/routes/routes_helper.dart';
import 'package:ecommerce/utils/app-constants.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/utils/dimensions.dart';
import 'package:ecommerce/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/populer_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  int pageId;

  CartPage({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var products =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(products, Get.find<CartController>());
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.initial);
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 8),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.initial);
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutesHelper.getCartPage(pageId));
                          },
                          child: AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                          )),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                iconColor: Colors.transparent,
                                backgroundColor: Colors.white,
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
                                color: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    return ListView.builder(
                      itemCount: cartController.getItems.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 5,
                          margin: EdgeInsets.only(bottom: Dimensions.height15),
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.listViewImgSize,
                                height: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConst.appBaseUrl +
                                        AppConst.upload +
                                        cartController.getItems[index].img!),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: Dimensions.listViewTextContSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                            text: cartController
                                                .getItems[index].name!),
                                        SizedBox(height: Dimensions.height10),
                                        SmallText(
                                          text: " chinese ",
                                          color: AppColors.signColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                                text:
                                                    "\$ ${cartController.getItems[index].price!} ",
                                                color: Colors.red),
                                            Container(
                                              height: Dimensions.height45,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Dimensions.radius15)),
                                                color: AppColors
                                                    .buttonBackgroundColor,
                                              ),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      cartController.addItem(
                                                          cartController
                                                              .getItems[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                      size: Dimensions.icon16,
                                                    ),
                                                    color: AppColors.signColor,
                                                  ),
                                                  BigText(
                                                      text:
                                                          "${cartController.getItems[index].quantity}"),
                                                  IconButton(
                                                    onPressed: () {
                                                      cartController.addItem(
                                                          cartController
                                                              .getItems[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                      size: Dimensions.icon16,
                                                    ),
                                                    color: AppColors.signColor,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
