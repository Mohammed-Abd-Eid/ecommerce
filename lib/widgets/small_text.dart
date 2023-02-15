// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  double height;
  SmallText({
    super.key,
    this.color = const Color(0xFF89dad0),
    required this.text,
    this.size = 12,
    this.overFlow = TextOverflow.ellipsis,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Roboto',
        height: height,
      ),
    );
  }
}
