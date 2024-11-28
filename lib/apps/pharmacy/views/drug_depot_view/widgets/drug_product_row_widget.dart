import 'package:flutter/material.dart';
import '../../../../../main_barrel.dart';

class DrugProductRowWidget extends StatelessWidget {
  final bool isHeading;
  final String? srNo;
  final ProductModel? product;
  final bool isSelected;
  final Function()? onTap;

  const DrugProductRowWidget({
    super.key,
    this.isHeading = false,
    this.srNo,
    this.product,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(tableRowPadding),
          width: double.infinity,
          decoration: BoxDecoration(
              color: isHeading ? Palette.primaryLight : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: isHeading
                  ? null
                  : Border.all(
                      width: 0.5,
                      color: isSelected ? Palette.secondary : Colors.white)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              product?.productImage != null
                  ? Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: tableRowImageSize,
                          width: tableRowImageSize,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: NetworkImageComponent(
                              imageUrl:
                                  '$storageBaseUrl/${product?.productImage}',
                            ),
                          ),
                        ),
                      ),
                    )
                  : isHeading
                      ? Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              image.tr(),
                              style: CustomFontStyle.regularText.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Palette.primary,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: tableRowImageSize,
                              width: tableRowImageSize,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                Assets.dummyParmacy,
                                height: tableRowImageSize,
                                width: tableRowImageSize,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    product?.productName ?? productName.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                        fontSize: isHeading ? 17 : 15,
                        fontWeight:
                            isHeading ? FontWeight.w500 : FontWeight.w400,
                        color: isHeading ? Palette.primary : Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    product?.costPrice != null
                        ? '\$${product!.costPrice!.toStringAsFixed(2)}'
                        : boxPrice.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                        fontSize: isHeading ? 17 : 15,
                        fontWeight:
                            isHeading ? FontWeight.w500 : FontWeight.w400,
                        color: isHeading ? Palette.primary : Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    product?.boxQuantity != null
                        ? product!.boxQuantity!.toStringAsFixed(2)
                        : quantityOfBox.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                        fontSize: isHeading ? 17 : 15,
                        fontWeight:
                            isHeading ? FontWeight.w500 : FontWeight.w400,
                        color: isHeading ? Palette.primary : Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    product != null
                        ? formatDate(product!.expiryDate!)
                        : expiryDate.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                        fontSize: isHeading ? 17 : 15,
                        fontWeight:
                            isHeading ? FontWeight.w500 : FontWeight.w400,
                        color: isHeading ? Palette.primary : Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    product?.barcode ?? barcodeNumber.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                        fontSize: isHeading ? 17 : 15,
                        fontWeight:
                            isHeading ? FontWeight.w500 : FontWeight.w400,
                        color: isHeading ? Palette.primary : Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: isHeading
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          actions.tr(),
                          style: CustomFontStyle.regularText.copyWith(
                              fontSize: isHeading ? 17 : 15,
                              fontWeight:
                                  isHeading ? FontWeight.w500 : FontWeight.w400,
                              color:
                                  isHeading ? Palette.primary : Colors.black),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: onTap,
                                child: const Icon(
                                  Icons.shopping_cart_rounded,
                                  color: Palette.green,
                                )),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        // if (!isHeading && isSelected && product != null)
        //   Positioned(
        //     right: 50,
        //     bottom: 0,
        //     child: ActionButtons(
        //       onTapView: () => showDialog(
        //         context: context,
        //         barrierDismissible: false,
        //         builder: (context) => AlertDialogComponent(
        //           child: AlertBodyProduct(product: product!),
        //         ),
        //       ),
        //       onTapApprove: () {
        //         BlocProvider.of<NavigationCubit>(context).updateNavigation(
        //           context,
        //           NavigationModel(
        //             'Products',
        //             UpdateProduct(
        //               showImage: true,
        //               product: product,
        //             ),
        //           ),
        //         );
        //       },
        //       onTapDelete: () => showDialog(
        //         context: context,
        //         barrierDismissible: false,
        //         builder: (context) => AlertDialogComponent(
        //           child: DialogGeneralBody(
        //             title: 'Delete',
        //             item: 'product',
        //             iconPath: Assets.trashImage,
        //             onTap: () {
        //               context
        //                   .read<ProductCubit>()
        //                   .deleteProduct(product!.id)
        //                   .whenComplete(() {
        //                 if (context.mounted) {
        //                   pop(context);
        //                 }
        //               });
        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
