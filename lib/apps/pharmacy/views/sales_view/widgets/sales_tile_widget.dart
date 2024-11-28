import 'package:flutter/material.dart';
import '../../../../../main_barrel.dart';

class SalesTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Sale sales;
  final bool isSelected;
  final int? index;

  const SalesTileWidget(
      {super.key,
      required this.sales,
      required this.onTap,
      this.index,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sales.customerName ?? '',
                      style: CustomFontStyle.regularText.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    RichTextWidget(
                      text1: "Transaction ID: ",
                      text2: sales.saleId ?? '',
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
                                text2: sales.totalAmount.toString(),
                                color1: Palette.grey,
                                fontSize1: 14.0,
                                fontSize2: 13.0,
                              ),
                              RichTextWidget(
                                text1: "Date: ",
                                text2: formatDate(sales.createdAt!) ?? '',
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
                                text2: sales.totalAmount.toString(),
                                color1: Palette.grey,
                                fontSize1: 14.0,
                                fontSize2: 13.0,
                              ),
                              RichTextWidget(
                                text1: "Date: ",
                                text2: formatDate(sales.createdAt!) ?? '',
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
                  ? 30
                  : null, // Left for Arabic
              right: context.locale == const Locale('en')
                  ? -40
                  : null, // Right for English
              bottom: 10,
              child: ActionButtons(
                onTapReturn: () {
                  // List<PurchasedProduct> orderedProducts = [];
                  // for (var item in sales.productList!) {
                  //   orderedProducts.add(PurchasedProduct(
                  //       boxQuantity: item.boxQuantity,
                  //       createdAt: item.createdAt,
                  //       id: item.id,
                  //       productId: item.productId,
                  //       productName: item.productName,
                  //       saleId: item.saleId,
                  //       sheetQuantity: item.sheetQuantity,
                  //       totalBoxPrice: item.totalBoxPrice,
                  //       totalSheetPrice: item.totalSheetPrice,
                  //       updatedAt: item.updatedAt));
                  // }
                  // SalesDetailsDialog().showSalesDialog(
                  //   context: context,
                  //   sales: sales,
                  //   productList: orderedProducts,
                  //   isReturend: true,
                  // );
                },
                onTapView: () {
                  // List<PurchasedProduct> orderedProducts = [];
                  // for (var item in sales.productList!) {
                  //   orderedProducts.add(PurchasedProduct(
                  //       boxQuantity: item.boxQuantity,
                  //       createdAt: item.createdAt,
                  //       id: item.id,
                  //       productId: item.productId,
                  //       productName: item.productName,
                  //       saleId: item.saleId,
                  //       sheetQuantity: item.sheetQuantity,
                  //       totalBoxPrice: item.totalBoxPrice,
                  //       totalSheetPrice: item.totalSheetPrice,
                  //       updatedAt: item.updatedAt));
                  // }
                  // SalesDetailsDialog().showSalesDialog(
                  //   context: context,
                  //   sales: sales,
                  //   productList: orderedProducts,
                  //   isReturend: false,
                  // );
                },
              ),
            ),
        ],
      ),
    );
  }
}
