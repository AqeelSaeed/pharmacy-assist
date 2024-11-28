import 'package:flutter/material.dart';
import 'package:pharmacy_assist/models/return_product_model.dart';
import '../../../../../main_barrel.dart';

class ReturnRowWidget extends StatelessWidget {
  final bool isHeading;
  final String? srNo;
  final Return? info;
  final bool isSelected;
  final Function()? onTap;

  const ReturnRowWidget({
    super.key,
    this.isHeading = false,
    this.srNo,
    this.info,
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
                      isHeading ? 'Customer' : info!.id.toString(),
                      style: CustomFontStyle.regularText.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Palette.primary,
                      ),
                    )),
              ),

              // Email Column
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading ? 'Previous Total' : info!.totalPrice.toString(),
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
                        ? 'Returned Amount'
                        : info!.saleId ?? 'Returned Amount',
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
                    isHeading ? 'Date' : formatDate(info!.createdAt!),
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
        if (!isHeading && isSelected)
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
                barrierDismissible: true,
                builder: (context) => const AlertDialogComponent(
                  child: Center(
                    child: Text(
                      'Under Maintainance',
                      style: CustomFontStyle.boldText,
                    ),
                  ),
                ),
              ),
              onTapDelete: () => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => const AlertDialogComponent(
                  child: Center(
                    child: Text(
                      'Under Maintainance',
                      style: CustomFontStyle.boldText,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
