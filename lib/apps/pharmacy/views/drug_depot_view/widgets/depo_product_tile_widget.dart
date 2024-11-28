import 'package:flutter/material.dart';
import '../../../../../main_barrel.dart';

class DepoProductTileWidget extends StatelessWidget {
  final ProductModel productDetail;
  final bool isSelected;
  final VoidCallback onTap;
  const DepoProductTileWidget(
      {super.key,
      required this.productDetail,
      this.isSelected = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Row(
          children: [
            const SizedBox(width: 16),
            CachedImageWidget(
                fallbackImage: "assets/icons/amoxil.png",
                url: "$storageBaseUrl${productDetail.productImage}"),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        productDetail.productName ?? '',
                        style: CustomFontStyle.regularText.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 15.0,
                      children: [
                        RichTextWidget(
                          text1: "1 Box Price: ",
                          text2: "${productDetail.retailPrice}",
                          color1: Palette.grey,
                          fontSize1: 14.0,
                          fontSize2: 13.0,
                        ),
                        RichTextWidget(
                          text1: "Cost Price: ",
                          text2: "${productDetail.costPrice}",
                          color1: Palette.grey,
                          fontSize1: 14.0,
                          fontSize2: 13.0,
                        ),
                      ],
                    ),
                  ),
                  RichTextWidget(
                    text1: "Sheet Price: ",
                    text2: productDetail.sheetPrice!.toStringAsFixed(2),
                    color1: Palette.grey,
                    fontSize1: 14.0,
                    fontSize2: 13.0,
                  ),
                  RichTextWidget(
                    text1: "Expiry Date: ",
                    text2: parseDate(productDetail.expiryDate!),
                    color2: Colors.red,
                    fontSize1: 14.0,
                    fontSize2: 12.0,
                  ),
                ],
              ),
            ),
          ],
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
      ]),
    );
  }
}
