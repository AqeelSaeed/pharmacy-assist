import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/shared_views/product_view/widgets/product_alert_dialog.dart';
import '../../../../main_barrel.dart';

class ProductTableRow extends StatelessWidget {
  final bool isHeading;
  final String? srNo;
  final ProductModel? product;
  final bool isSelected;
  final Function()? onTap;

  const ProductTableRow({
    super.key,
    this.isHeading = false,
    this.srNo,
    this.product,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(15),
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
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: CachedImageWidget(
                              height: 40,
                              width: 40,
                              url: '$storageBaseUrl/${product?.productImage}'),
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
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                Assets.dummyParmacy,
                                height: 40,
                                width: 40,
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
                    product?.retailPrice != null
                        ? '\$${product!.retailPrice!.toStringAsFixed(2)}'
                        : boxRetailPrice.tr(),
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
                                child: const Icon(Icons.more_horiz)),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        if (!isHeading && isSelected && product != null)
          Positioned(
            left: context.locale == const Locale('ar')
                ? 80
                : null, // Left for Arabic
            right: context.locale == const Locale('en')
                ? 50
                : null, // Right for English
            bottom: 10,
            child: ActionButtons(
              onTapView: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialogComponent(
                  child: ProductAlertDialog(product: product!),
                ),
              ),
              onTapApprove: () {
                BlocProvider.of<NavigationCubit>(context).updateNavigation(
                  context,
                  NavigationModel(
                    products.tr(),
                    AddUpdateProductView(
                      showImage: true,
                      product: product,
                    ),
                  ),
                );
              },
              onTapDelete: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialogComponent(
                  child: DialogGeneralBody(
                    title: delete.tr(),
                    item: productKey.tr(),
                    iconPath: Assets.trashImage,
                    onTap: () {
                      context
                          .read<ProductCubit>()
                          .deleteProduct(product!.id ?? '')
                          .whenComplete(() {
                        if (context.mounted) {
                          pop(context);
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
