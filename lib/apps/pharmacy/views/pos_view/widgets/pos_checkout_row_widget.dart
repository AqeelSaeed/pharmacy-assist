import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../main_barrel.dart';

class PosCheckoutRowWidget extends StatefulWidget {
  final bool isHeading;
  final String? srNo;
  final ProductModel? cartItem;
  final int? totalBoxes, totalSheets;

  const PosCheckoutRowWidget(
      {super.key,
      this.isHeading = false,
      this.cartItem,
      this.srNo,
      this.totalBoxes,
      this.totalSheets});

  @override
  State<PosCheckoutRowWidget> createState() => _PosCheckoutRowWidgetState();
}

class _PosCheckoutRowWidgetState extends State<PosCheckoutRowWidget> {
  final boxQuantityController = TextEditingController();
  final sheetQuantityController = TextEditingController();
  bool hasCartItem = false;
  bool hasorderedProducts = false;
  double totalAmount = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.cartItem != null) {
        hasorderedProducts = widget.cartItem != null;
        setState(() {
          boxQuantityController.text = widget.cartItem!.boxQuantity.toString();
          sheetQuantityController.text =
              widget.cartItem!.sheetQuantity.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cartItem != null) {
      totalAmount = 90.0;
    }
    return Container(
      padding: EdgeInsets.only(top: hasCartItem ? 15 : 0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  widget.isHeading ? serialNumber.tr() : widget.srNo ?? '',
                  style: CustomFontStyle.regularText.copyWith(
                    fontSize: widget.isHeading ? 17 : 15,
                    fontWeight:
                        widget.isHeading ? FontWeight.w500 : FontWeight.w400,
                    color: widget.isHeading ? Palette.primary : Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.isHeading
                        ? medicine.tr()
                        : widget.cartItem != null
                            ? widget.cartItem!.productName ?? ''
                            : widget.cartItem != null
                                ? widget.cartItem!.productName ?? ''
                                : '',
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: widget.isHeading ? 17 : 15,
                      fontWeight:
                          widget.isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: widget.isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: widget.isHeading
                      ? Text(
                          quantity.tr(),
                          style: CustomFontStyle.regularText.copyWith(
                            fontSize: widget.isHeading ? 17 : 15,
                            fontWeight: widget.isHeading
                                ? FontWeight.w500
                                : FontWeight.w400,
                            color: widget.isHeading
                                ? Palette.primary
                                : Colors.black,
                          ),
                        )
                      : Column(
                          children: [
                            if (hasCartItem)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${box.tr()}: ${widget.cartItem != null ? widget.cartItem!.boxQuantity : widget.totalBoxes}',
                                    style: CustomFontStyle.regularText,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${sheets.tr()}: ${widget.cartItem != null ? widget.cartItem!.sheetQuantity : widget.totalSheets}',
                                    style: CustomFontStyle.regularText,
                                  ),
                                ],
                              ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${box.tr()}:',
                                          style: CustomFontStyle.regularText,
                                        ),
                                      ),
                                      const SizedBox(width: 3.5),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: TextFieldComponent(
                                            onChanged: (value) {
                                              if (widget.cartItem != null) {
                                                log('newBoxQuantity: $value');
                                                // context
                                                //     .read<CartCubit>()
                                                //     .updateBoxQuantity(
                                                //         orderedProduct: widget
                                                //             .orderedProducts,
                                                //         quantity: int.parse(
                                                //             value
                                                //                 .toString()));
                                              }
                                            },
                                            controller: boxQuantityController,
                                            verticalPadding: 2,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${sheets.tr()}:',
                                          style: CustomFontStyle.regularText,
                                        ),
                                      ),
                                      const SizedBox(width: 3.5),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: TextFieldComponent(
                                            onChanged: (value) {
                                              final typedQuantity =
                                                  int.tryParse(value) ?? 0;
                                              if (widget.cartItem != null) {
                                                log('newSheetQuantity: $typedQuantity');
                                                // context
                                                //     .read<CartCubit>()
                                                //     .updateSheetQuantity(
                                                //         orderedProduct: widget
                                                //             .orderedProducts!,
                                                //         quantity:
                                                //             typedQuantity);
                                              }
                                            },
                                            controller: sheetQuantityController,
                                            verticalPadding: 2,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.isHeading
                        ? '${price.tr()} (IQR)'
                        : widget.cartItem != null
                            ? totalAmount.toString()
                            : totalAmount.toString(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: widget.isHeading ? 17 : 15,
                      fontWeight:
                          widget.isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: widget.isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
