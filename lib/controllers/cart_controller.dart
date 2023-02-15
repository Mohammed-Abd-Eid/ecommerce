// ignore_for_file: prefer_final_fields, avoid_print

import 'package:ecommerce/data/repository/cart_repo.dart';
import 'package:ecommerce/models/cart_models.dart';
import 'package:ecommerce/models/product_models.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModels> _items = {};
  Map<int, CartModels> get items => _items;

  void addItem(ProductModels productModels, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(productModels.id)) {
      _items.update(productModels.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModels(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          time: DateTime.now().toString(),
          isExit: true,
          product: productModels,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(productModels.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(productModels.id!, () {
          return CartModels(
            id: productModels.id,
            name: productModels.name,
            price: productModels.price,
            img: productModels.img,
            quantity: quantity,
            time: DateTime.now().toString(),
            isExit: true,
            product: productModels,
          );
        });
      } else {
        Get.snackbar(
          "Item Count",
          "You Can't Add More !",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    update();
  }

  bool existInCart(ProductModels productModels) {
    if (_items.containsKey(productModels.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModels product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity = totalQuantity + value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModels> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
}
