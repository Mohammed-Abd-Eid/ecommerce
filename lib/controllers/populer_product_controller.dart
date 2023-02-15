// ignore_for_file: avoid_print, unused_field, prefer_final_fields

import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/data/repository/popular_product_repo.dart';
import 'package:ecommerce/models/cart_models.dart';
import 'package:ecommerce/models/product_models.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cartController;
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("get products //////////////");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoad = true;
      update();
    } else {
      print("Error");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item Count",
        "You Can't Reduce More !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item Count",
        "You Can't Add More !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModels productModels, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cart;
    var exist = false;
    exist = cart.existInCart(productModels);
    if (exist) {
      _inCartItems = _cartController.getQuantity(productModels);
    }
  }

  void addItems(ProductModels productModels) {
    if (_quantity > 0) {
      _cartController.addItem(productModels, _quantity);
      _quantity = 0;
      _inCartItems = _cartController.getQuantity(productModels);
      _cartController.items.forEach((key, value) {});
    } else {
      Get.snackbar(
        "Item Count",
        "You Can't Add More !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
    }
    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModels> get getItems {
    return _cartController.getItems;
  }
}
