import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmacy_assist/main_barrel.dart';

class StatsCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;
  final Color? iconBackgroundColor;
  final double? height;
  const StatsCard(
      {super.key,
      required this.iconPath,
      this.iconBackgroundColor,
      this.height,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor ?? Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                iconPath,
                height: 72,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: CustomFontStyle.regularText
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                style:
                    CustomFontStyle.boldText.copyWith(color: Palette.primary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
