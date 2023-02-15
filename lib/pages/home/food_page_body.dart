// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, must_call_super, prefer_interpolation_to_compose_strings

import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/controllers/populer_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/models/product_models.dart';
import 'package:ecommerce/routes/routes_helper.dart';
import 'package:ecommerce/utils/app-constants.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/utils/dimensions.dart';
import 'package:ecommerce/widgets/big_text.dart';
import 'package:ecommerce/widgets/icon_and_text_widget.dart';
import 'package:ecommerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var currentPage = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return popularProduct.isLoad
              ? Container(
                  height: Dimensions.pageView,
                  child: GestureDetector(
                    onTap: () {
                      //    Get.toNamed(RoutesHelper.getPopularFood());
                    },
                    child: PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProduct.popularProductList[position]);
                      },
                      itemCount: popularProduct.popularProductList.length,
                    ),
                  ),
                )
              : CircularProgressIndicator(color: AppColors.mainColor);
        }),
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProductList.isEmpty
                ? 1
                : popularProduct.popularProductList.length,
            position: currentPage,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: "."),
              ),
              SizedBox(width: Dimensions.width10),
              Container(child: SmallText(text: "Food pairing")),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(builder: (
          recommendedProduct,
        ) {
          return recommendedProduct.isLoad
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.getRecommendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.height10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConst.appBaseUrl +
                                      AppConst.upload +
                                      recommendedProduct
                                          .recommendedProductList[index].img!),
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
                                    top: Dimensions.height10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .name!),
                                      SizedBox(height: Dimensions.height10),
                                      SmallText(
                                        text: "With chinese characteristics",
                                        color: AppColors.signColor,
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                            icon: Icons.circle,
                                            text: "Normal",
                                            iconColor: AppColors.iconColor1,
                                          ),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7Km",
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time,
                                              text: "32min",
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(color: AppColors.mainColor);
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModels popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPage.floor()) {
      var currScale = 1 - (currentPage - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPage.floor() + 1) {
      var currScale =
          scaleFactor + (currentPage - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPage.floor() - 1) {
      var currScale = 1 - (currentPage - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RoutesHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConst.appBaseUrl +
                      AppConst.upload +
                      popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: Dimensions.height15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                        text: popularProduct.name!, size: Dimensions.font20),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star_outlined,
                                    color: AppColors.mainColor,
                                    size: 16,
                                  )),
                        ),
                        SizedBox(width: Dimensions.height10),
                        SmallText(text: "4.8", color: Colors.grey, size: 14),
                        SizedBox(width: Dimensions.height10),
                        SmallText(text: "1200", color: Colors.grey, size: 14),
                        SizedBox(width: Dimensions.height10),
                        SmallText(
                            text: "comments",
                            color: Colors.grey,
                            size: Dimensions.font15),
                      ],
                    ),
                    SizedBox(height: Dimensions.height20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                          icon: Icons.circle,
                          text: "Normal",
                          iconColor: AppColors.iconColor1,
                        ),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: "1.7Km",
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.access_time,
                            text: "32min",
                            iconColor: AppColors.iconColor2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
