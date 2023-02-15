// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this, unnecessary_null_comparison
import 'package:ecommerce/models/product_models.dart';

class CartModels {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExit;
  String? time;
  ProductModels? product;
  CartModels({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.time,
    this.isExit,
    this.product,
  });

  CartModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExit = json['isExit'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['img'] = this.img;
    data['quantity'] = this.quantity;
    data['time'] = this.time;
    data['isExit'] = this.isExit;
    data['product'] = this.product;
    return data;
  }
}
