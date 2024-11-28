import 'package:flutter/material.dart';
import 'package:pharmacy_assist/theme_data/theme_data.dart';

class RichTextWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Color color1;
  final Color color2;
  final double fontSize1;
  final double fontSize2;
  final FontWeight fontWeight1;
  final FontWeight fontWeight2;

  const RichTextWidget({
    super.key,
    required this.text1,
    required this.text2,
    this.color1 = Colors.black,
    this.color2 = Colors.black,
    this.fontSize1 = 15.0,
    this.fontSize2 = 15.0,
    this.fontWeight1 = FontWeight.w500,
    this.fontWeight2 = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: CustomFontStyle.regularText.copyWith(
                fontSize: fontSize1, fontWeight: fontWeight1, color: color1),
          ),
          TextSpan(
            text: text2,
            style: CustomFontStyle.regularText.copyWith(
                fontSize: fontSize2, fontWeight: fontWeight2, color: color2),
          ),
        ],
      ),
    );
  }
}
