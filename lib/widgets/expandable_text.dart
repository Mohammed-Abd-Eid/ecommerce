// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/utils/dimensions.dart';
import 'package:ecommerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              color: AppColors.paraColor,
              size: Dimensions.font16,
            )
          : Column(
              children: [
                SmallText(
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                  color: AppColors.paraColor,
                  overFlow: TextOverflow.visible,
                  size: Dimensions.font16,
                  height: 1.6,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                          text: hiddenText ? "Show more" : "Show loss",
                          color: AppColors.mainColor),
                      hiddenText
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.mainColor,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.mainColor,
                            )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
