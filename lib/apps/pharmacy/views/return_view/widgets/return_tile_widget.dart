import 'package:flutter/material.dart';
import 'package:pharmacy_assist/models/return_product_model.dart';

import '../../../../../main_barrel.dart';

class ReturnTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Return returns;
  final bool isSelected;

  const ReturnTileWidget(
      {super.key,
      required this.returns,
      required this.onTap,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    returns.id ?? '',
                    style: CustomFontStyle.regularText.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  RichTextWidget(
                    text1: "Transaction ID: ",
                    text2: returns.saleId ?? '',
                    color2: Colors.red,
                    fontSize1: 14.0,
                    fontSize2: 12.0,
                  ),
                  Responsive.isTablet(context)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichTextWidget(
                              text1: "Total Amount: ",
                              text2: returns.totalPrice.toString(),
                              color1: Palette.grey,
                              fontSize1: 14.0,
                              fontSize2: 13.0,
                            ),
                            RichTextWidget(
                              text1: "Date: ",
                              text2: formatDate(returns.createdAt!) ?? '',
                              color1: Palette.grey,
                              fontSize1: 14.0,
                              fontSize2: 13.0,
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichTextWidget(
                              text1: "Total Amount: ",
                              text2: returns.totalPrice.toString(),
                              color1: Palette.grey,
                              fontSize1: 14.0,
                              fontSize2: 13.0,
                            ),
                            RichTextWidget(
                              text1: "Date: ",
                              text2: formatDate(returns.createdAt!) ?? '',
                              color1: Palette.grey,
                              fontSize1: 14.0,
                              fontSize2: 13.0,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Image.asset(
                      Assets.greenPile,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        if (isSelected)
          Positioned(
            left: context.locale == const Locale('ar')
                ? 80
                : null, // Left for Arabic
            right: context.locale == const Locale('en')
                ? 50
                : null, // Right for English
            bottom: 10,
            child: ActionButtons(
              onTapView: () {},
              onTapApprove: () {},
              onTapDelete: () {},
            ),
          ),
      ]),
    );
  }
}
