import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main_barrel.dart';

class StaffTileWidget extends StatelessWidget {
  final ProductModel productDetail;
  final bool isSelected;
  const StaffTileWidget(
      {super.key, required this.productDetail, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Row(
          children: [
            const SizedBox(width: 6),
            CachedImageWidget(
                fallbackImage: "assets/icons/amoxil.png",
                url: "$storageBaseUrl${productDetail.productImage}"),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Row(
                      children: [
                        Text(
                          '${productDetail.productName} x(${productDetail.boxQuantity})',
                          style: CustomFontStyle.regularText.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        const Spacer(),
                        RichTextWidget(
                          text1: "Exp: ",
                          text2: parseDate(productDetail.expiryDate!),
                          color2: Colors.red,
                          fontSize1: 14.0,
                          fontSize2: 12.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  RichTextWidget(
                    text1: "1 Box Price: ",
                    text2: "${productDetail.retailPrice}",
                    color1: Palette.grey,
                    fontSize1: 14.0,
                    fontSize2: 13.0,
                  ),
                  const SizedBox(height: 5),
                  RichTextWidget(
                    text1: "Cost Price: ",
                    text2: "${productDetail.costPrice}",
                    color1: Palette.grey,
                    fontSize1: 14.0,
                    fontSize2: 13.0,
                  ),
                  const SizedBox(height: 5),
                  RichTextWidget(
                    text1: "Sheet Price: ",
                    text2: productDetail.sheetPrice!.toStringAsFixed(2),
                    color1: Palette.grey,
                    fontSize1: 14.0,
                    fontSize2: 13.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 1,
          bottom: 1,
          child: PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  onTap: () => showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => const AlertDialogComponent(
                          child: SizedBox(height: 200, width: 200),
                        ),
                      ),
                  child: const Text(
                    "View",
                    style: CustomFontStyle.regularText,
                  )),
              PopupMenuItem(
                  value: 2,
                  onTap: () {},
                  child: const Text(
                    "Edit",
                    style: CustomFontStyle.regularText,
                  )),
              PopupMenuItem(
                  value: 3,
                  onTap: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const AlertDialogComponent(
                          child: SizedBox(height: 200, width: 200),
                        ),
                      ),
                  child: const Text(
                    "Delete",
                    style: CustomFontStyle.regularText,
                  )),
            ],
            offset: const Offset(0, 20),
            color: Palette.secondary,
            elevation: 2,
          ),
        )
      ]),
    );
  }
}
