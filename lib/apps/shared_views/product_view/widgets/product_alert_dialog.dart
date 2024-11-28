import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../main_barrel.dart';

class ProductAlertDialog extends StatelessWidget {
  final ProductModel product;

  const ProductAlertDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    log('message: ${product.productImage}');
    return Stack(
      children: [
        Container(
          width: 400,
          height: MediaQuery.sizeOf(context).height * 0.7,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: NetworkImageComponent(
                    size: 135,
                    imageUrl: '$storageBaseUrl${product.productImage}'),
              ),
              const SizedBox(height: 10),
              Text(productDetails.tr(),
                  style: CustomFontStyle.boldText.copyWith(
                      fontSize: Responsive.isMobile(context) ? 14 : 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _Row(
                          title: productName.tr(),
                          value: product.productName ?? ''),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: barcodeNumber.tr(),
                          value: product.barcode ?? ''),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: quantityOfBox.tr(),
                          value: '${product.boxQuantity} ${boxes.tr()}'),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: boxRetailPrice.tr(),
                          value:
                              '\$${product.retailPrice!.toStringAsFixed(2)} ${perBox.tr()}'),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: costPrice.tr(),
                          value:
                              '\$${product.costPrice!.toStringAsFixed(2)} ${perBox.tr()}'),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: sheetInBox.tr(),
                          value: '${product.sheetInBox} ${sheets.tr()}'),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: tableInSheet.tr(),
                          value:
                              '${product.tabletInSheet} ${tabletIn1Sheet.tr()}'),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: expiryDate.tr(),
                          value: formatDate(product.expiryDate!)),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: scientificName.tr(),
                          value: product.scientificName ?? ''),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff9D9D9D),
                        thickness: 0.3,
                        height: 0.3,
                      ),
                      const SizedBox(height: 20),
                      _Row(
                          title: description.tr(),
                          value: product.description ?? ''),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(60),
            onTap: () => Navigator.pop(context),
            child: Image.asset(Assets.closeIcon, width: 28),
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final String value;

  const _Row({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: CustomFontStyle.regularText),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: CustomFontStyle.regularText
                .copyWith(color: Palette.grey, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
