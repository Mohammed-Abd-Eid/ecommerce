// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:ecommerce/utils/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  BigText({
    super.key,
    this.color = const Color(0xff332d2d),
    required this.text,
    this.size = 0,
    this.overFlow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
    );
  }
}
