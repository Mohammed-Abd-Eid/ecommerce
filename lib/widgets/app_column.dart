import 'package:ecommerce/widgets/big_text.dart';
import 'package:ecommerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font20),
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
                text: "comments", color: Colors.grey, size: Dimensions.font15),
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
    );
  }
}
