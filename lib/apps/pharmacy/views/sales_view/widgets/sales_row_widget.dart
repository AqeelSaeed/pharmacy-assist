import 'package:flutter/material.dart';
import '../../../../../main_barrel.dart';
import 'sales_details_dialog.dart';

class SalesRowWidget extends StatelessWidget {
  final bool isHeading;
  final String? srNo;
  final Sale? sales;
  final bool isSelected;
  final int? index;
  final Function()? onTap;

  const SalesRowWidget({
    super.key,
    this.isHeading = false,
    this.index,
    this.srNo,
    this.sales,
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
          padding: EdgeInsets.all(tableRowPadding),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isHeading ? Palette.primaryLight : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: isHeading
                ? null
                : Border.all(
                    width: 0.5,
                    color: isSelected ? Palette.secondary : Colors.white,
                  ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // License Image Column
              Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      isHeading ? serialNumber.tr() : srNo ?? '',
                      style: CustomFontStyle.regularText.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Palette.primary,
                      ),
                    )),
              ),
              // Name Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? customer.tr()
                        : sales?.customerName ?? customer.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Email Column
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? transactionId.tr()
                        : sales?.saleId ?? transactionId.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Phone Number Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? totalAmount.tr()
                        : sales?.totalAmount.toString() ?? totalAmount.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Warehouse Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? date.tr()
                        : formatDateToMonth(sales!.createdAt!).toString(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Total Products Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? time.tr()
                        : formatTime(sales!.createdAt!).toString(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Action Column
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: isHeading
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            actions.tr(),
                            style: CustomFontStyle.regularText.copyWith(
                                fontSize: isHeading ? 17 : 15,
                                fontWeight: isHeading
                                    ? FontWeight.w500
                                    : FontWeight.w400,
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
              ),
            ],
          ),
        ),
        if (!isHeading && isSelected && sales != null)
          Positioned(
            left: context.locale == const Locale('ar')
                ? 80
                : null, // Left for Arabic
            right: context.locale == const Locale('en')
                ? 10
                : null, // Right for English
            bottom: 10,
            child: ActionButtons(
              onTapReturn: () {
                SalesDetailsDialog().showSalesDialog(
                  context: context,
                  sales: sales!,
                  productList: sales!.productList!,
                  isReturend: 1,
                );
              },
            ),
          ),
      ],
    );
  }
}
